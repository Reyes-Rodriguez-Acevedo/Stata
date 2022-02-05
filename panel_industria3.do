log using "C:\Documents and Settings\Reyes Rodriguez A\Mis documentos\IESA\investigacion industria\panel\panel_industria3.log", replace
set mem 100m
set more off 

use "C:\Documents and Settings\Reyes Rodriguez A\Mis documentos\IESA\investigacion industria\panel\industria_log.dta"

*******Previa*******
keep if z4==1
gen a2=z10^2
gen a3=z10^3
gen k2=z26^2
gen k3=z26^3
gen ak=z10*z26
gen a2k=a2*z26
gen ak2=z10*k2

*****Primera etapa*****
iis(empresa)
tis(z1)
xtreg z14 z27 z12 z13 d* z10 z26 a2 ak k2 a3 a2k ak2 k3, fe
gen alpha1=z27*_b[z27]
gen alpha2=z12*_b[z12]
gen alpha3=z13*_b[z13]
gen beta0=_b[_cons]
gen beta1=z10*_b[z10]
gen beta2=z26*_b[z26]
gen beta3=a2*_b[a2]
gen beta4=ak*_b[ak]
gen beta5=k2*_b[k2]
gen beta6=a3*_b[a3]
gen beta7=a2k*_b[a2k]
gen beta8=ak2*_b[ak2]
gen beta9=k3*_b[k3]
gen alpha=alpha1+alpha2+alpha3
replace alpha=. if(alpha1==.|alpha2==.|alpha3==.)
gen phi=beta0+beta1+beta2+beta3+beta4+beta5+beta6+beta7+beta8+beta9
replace phi=. if(beta0==.|beta1==.|beta2==.|beta3==.|beta4==.|beta5==.|beta6==.|beta7==.|beta8==.|beta9==.)
gen h=beta3+beta4+beta5+beta6+beta7+beta8+beta9
replace h=. if(beta3==.|beta4==.|beta5==.|beta6==.|beta7==.|beta8==.|beta9==.)

gen z14_sinalpha=z14-alpha
replace z14_sinalpha=. if(z14==.|alpha==.)

*****Segunda etapa*****
sort empresa z1
merge empresa z1 using "C:\Documents and Settings\Reyes Rodriguez A\Mis documentos\IESA\investigacion industria\panel\probit.dta"
drop _merge
replace probit=0 if z14==.
replace probit=. if z4~=1
keep if z4==1
bysort z4: sum probit
iis(empresa)
tis(z1)
xtprobit probit z10 z26 a2 ak k2 a3 a2k ak2 k3,re
predict p, pu0
sum p
bysort z4: sum p
predict probit_fit
sum probit_fit
bysort z4: sum probit_fit

*****Tercera etapa*****
gen h2=h^2
gen h3=h^3
gen p2=p^2
gen p3=p^3
gen hp=h*p
gen h2p=h2*p
gen hp2=h*p2
gen z14_forward1=z14_sinalpha[_n+1]
gen z10_forward1=z10[_n+1]
gen z26_forward1=z26[_n+1]
iis(empresa)
tis(z1)
xtreg z14_forward1 z10_forward1 z26_forward1 h2 hp p2 h3 h2p hp2 p3, fe
gen beta_a=z10*_b[z10_forward1]
gen beta_k=z26*_b[z26_forward1]
gen w=z14-beta0-alpha1-alpha2-alpha3-beta_a-beta_k
replace w=. if(z14==.|beta0==.|alpha1==.|alpha2==.|alpha3==.|beta_a==.|beta_k==.)
sum w
bysort z4: sum w
bysort empresa: sum w
tab w

*****Cuarta etapa*****
gen z33z34=z33+z34
replace z33z34=. if(z33==.|z34==.)
iis(empresa)
tis(z1)
***sin dummies***
xtreg w z33, fe
xtreg w z34, fe
xtreg w z33z34, fe
xtreg w z33 z34, fe
xtreg w z39, fe
xtreg w z40, fe
xtreg w z41, fe
xtreg w z42, fe
xtreg w z39 z40 z41, fe
xtreg w z33z34 z42, fe
xtreg w z33 z34 z39 z40 z41, fe
***con dummies***
xtreg w z33 d*, fe
xtreg w z34 d*, fe
xtreg w z33z34 d*, fe
xtreg w z33 z34 d*, fe
xtreg w z39 d*, fe
xtreg w z40 d*, fe
xtreg w z41 d*, fe
xtreg w z42 d*, fe
xtreg w z39 z40 z41 d*, fe
xtreg w z33z34 z42 d*, fe
xtreg w z33 z34 z39 z40 z41 d*, fe


sort empresa z1

save "C:\Documents and Settings\Reyes Rodriguez A\Mis documentos\IESA\investigacion industria\panel\panel_industria3.dta", replace

clear
log close

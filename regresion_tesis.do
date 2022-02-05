clear
set mem 1000m
set more off

log using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis.log", replace

*******REGRESIONES CORTE TRANSVERSAL*******
use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
collapse (mean) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_m
rename gdp gdp_m
rename deflator deflator_m
rename ersi ersi_m
rename mii mii_m
rename foi foi_m
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
collapse (sd) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_sd
rename gdp gdp_sd
rename deflator deflator_sd
rename ersi ersi_sd
rename mii mii_sd
rename foi foi_sd
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean.dta"
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd.dta", unique sort
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis.dta", replace

regress inflation_m gdp_sd, robust hc3
regress inflation_m gdp_sd ersi_m mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m mii_m, robust hc3
regress inflation_m gdp_sd ersi_m foi_m, robust hc3
regress inflation_m gdp_sd mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m, robust hc3
regress inflation_m gdp_sd mii_m, robust hc3
regress inflation_m gdp_sd foi_m, robust hc3
regress inflation_m gdp_sd
clear


*******REGRESIONES CORTE TRANSVERSAL 80*******
use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1980 & year<=1989
collapse (mean) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_m
rename gdp gdp_m
rename deflator deflator_m
rename ersi ersi_m
rename mii mii_m
rename foi foi_m
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean80.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1980 & year<=1989
collapse (sd) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_sd
rename gdp gdp_sd
rename deflator deflator_sd
rename ersi ersi_sd
rename mii mii_sd
rename foi foi_sd
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd80.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean80.dta"
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd80.dta", unique sort
drop _merge
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis80.dta", replace
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_central_bank_autonomy_80.dta", unique sort
drop _merge
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis80.dta", replace

regress inflation_m gdp_sd, robust hc3
regress inflation_m gdp_sd ersi_m mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m mii_m, robust hc3
regress inflation_m gdp_sd ersi_m foi_m, robust hc3
regress inflation_m gdp_sd mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m, robust hc3
regress inflation_m gdp_sd mii_m, robust hc3
regress inflation_m gdp_sd foi_m, robust hc3
regress inflation_m gdp_sd
regress inflation_m gdp_sd cbapolitical, robust hc3
regress inflation_m gdp_sd cbaeconomic, robust hc3
regress inflation_m gdp_sd cbaoverall, robust hc3
clear


*******REGRESIONES CORTE TRANSVERSAL 90*******
use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1990 & year<=1999
collapse (mean) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_m
rename gdp gdp_m
rename deflator deflator_m
rename ersi ersi_m
rename mii mii_m
rename foi foi_m
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean90.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1990 & year<=1999
collapse (sd) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_sd
rename gdp gdp_sd
rename deflator deflator_sd
rename ersi ersi_sd
rename mii mii_sd
rename foi foi_sd
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd90.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean90.dta"
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd90.dta", unique sort
drop _merge
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis90.dta", replace
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_central_bank_autonomy_2003.dta", unique sort
drop _merge
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis90.dta", replace

regress inflation_m gdp_sd, robust hc3
regress inflation_m gdp_sd ersi_m mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m mii_m, robust hc3
regress inflation_m gdp_sd ersi_m foi_m, robust hc3
regress inflation_m gdp_sd mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m, robust hc3
regress inflation_m gdp_sd mii_m, robust hc3
regress inflation_m gdp_sd foi_m, robust hc3
regress inflation_m gdp_sd
regress inflation_m gdp_sd cbapolitical, robust hc3
regress inflation_m gdp_sd cbaeconomic, robust hc3
regress inflation_m gdp_sd cbaoverall, robust hc3
clear


*******REGRESIONES CORTE TRANSVERSAL 2000*******
use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=2000 & year<=2012
collapse (mean) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_m
rename gdp gdp_m
rename deflator deflator_m
rename ersi ersi_m
rename mii mii_m
rename foi foi_m
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean2000.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=2000 & year<=2012
collapse (sd) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_sd
rename gdp gdp_sd
rename deflator deflator_sd
rename ersi ersi_sd
rename mii mii_sd
rename foi foi_sd
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd2000.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean2000.dta"
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd2000.dta", unique sort
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis2000.dta", replace

regress inflation_m gdp_sd, robust hc3
regress inflation_m gdp_sd ersi_m mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m, robust hc3
regress inflation_m gdp_sd
regress inflation_m gdp_sd ersi_m mii_m foi_m
regress inflation_m gdp_sd ersi_m

clear


*******REGRESIONES CORTE TRANSVERSAL 94*******
use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1980 & year<=1994
collapse (mean) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_m
rename gdp gdp_m
rename deflator deflator_m
rename ersi ersi_m
rename mii mii_m
rename foi foi_m
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean94.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1980 & year<=1994
collapse (sd) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_sd
rename gdp gdp_sd
rename deflator deflator_sd
rename ersi ersi_sd
rename mii mii_sd
rename foi foi_sd
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd94.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean94.dta"
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd94.dta", unique sort
drop _merge
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis94.dta", replace
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_central_bank_autonomy_80.dta", unique sort
drop _merge
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis94.dta", replace

regress inflation_m gdp_sd, robust hc3
regress inflation_m gdp_sd ersi_m mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m mii_m, robust hc3
regress inflation_m gdp_sd ersi_m foi_m, robust hc3
regress inflation_m gdp_sd mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m, robust hc3
regress inflation_m gdp_sd mii_m, robust hc3
regress inflation_m gdp_sd foi_m, robust hc3
regress inflation_m gdp_sd
regress inflation_m gdp_sd cbapolitical, robust hc3
regress inflation_m gdp_sd cbaeconomic, robust hc3
regress inflation_m gdp_sd cbaoverall, robust hc3
clear


*******REGRESIONES CORTE TRANSVERSAL 95*******
use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1995 & year<=2012
collapse (mean) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_m
rename gdp gdp_m
rename deflator deflator_m
rename ersi ersi_m
rename mii mii_m
rename foi foi_m
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean95.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1995 & year<=2012
collapse (sd) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_sd
rename gdp gdp_sd
rename deflator deflator_sd
rename ersi ersi_sd
rename mii mii_sd
rename foi foi_sd
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd95.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean95.dta"
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd95.dta", unique sort
drop _merge
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis95.dta", replace
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_central_bank_autonomy_2003.dta", unique sort
drop _merge
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis95.dta", replace

regress inflation_m gdp_sd, robust hc3
regress inflation_m gdp_sd ersi_m mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m mii_m, robust hc3
regress inflation_m gdp_sd ersi_m foi_m, robust hc3
regress inflation_m gdp_sd mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m, robust hc3
regress inflation_m gdp_sd mii_m, robust hc3
regress inflation_m gdp_sd foi_m, robust hc3
regress inflation_m gdp_sd
regress inflation_m gdp_sd cbapolitical, robust hc3
regress inflation_m gdp_sd cbaeconomic, robust hc3
regress inflation_m gdp_sd cbaoverall, robust hc3
clear


*******REGRESIONES CORTE TRANSVERSAL 2003*******
use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1980 & year<=2003
collapse (mean) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_m
rename gdp gdp_m
rename deflator deflator_m
rename ersi ersi_m
rename mii mii_m
rename foi foi_m
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean2003.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_tesis.dta"
iis(imfcode)
tis(year)
tsset imfcode year, yearly
bysort imfcode: gen dgdp = d.gdp
drop gdp
rename dgdp gdp
keep if year>=1980 & year<=2003
collapse (sd) inflation gdp deflator neer reer m1 nnat wkan mona xrp ffit iit itl ersi mii foi hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle, by (imfcode iso country)
drop neer reer m1 nnat wkan mona xrp ffit iit itl hp100gdptrend hp100gdpcycle hp16gdptrend hp16gdpcycle cf28gdptrend cf28gdpcycle
rename inflation inflation_sd
rename gdp gdp_sd
rename deflator deflator_sd
rename ersi ersi_sd
rename mii mii_sd
rename foi foi_sd
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd2003.dta", replace
clear

use "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_mean2003.dta"
merge imfcode iso country using "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\database_sd2003.dta", unique sort
save "C:\Users\Rodriguez Valarino\Documents\Post Grado\UCAB\Tesis\Database\regresion_tesis2003.dta", replace

regress inflation_m gdp_sd, robust hc3
regress inflation_m gdp_sd ersi_m mii_m foi_m, robust hc3
regress inflation_m gdp_sd ersi_m, robust hc3
regress inflation_m gdp_sd
regress inflation_m gdp_sd ersi_m mii_m foi_m
regress inflation_m gdp_sd ersi_m

clear


clear

log close

exit

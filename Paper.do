cd "/Users/SONY/Desktop/Spring 2022/ECON107/Econometrics Paper/DTA"
use "GDP.dta"
su gdp
generate log_gdp = log(gdp)
su log_gdp
save logGDP.dta, replace

use "GNS.dta", clear
su savings

use "TRD.dta", clear
su trade

use "FDI.dta", clear
su fdi

use "UEM.dta", clear
su unemployment

use "MANF.dta", clear
su manufacturing

use "EDUC.dta", clear
su education

use "LE.dta", clear

use "logGDP.dta", clear
merge 1:1 countrycode using GNS.dta, nogen
merge 1:1 countrycode using TRD.dta, nogen
merge 1:1 countrycode using FDI.dta, nogen
merge 1:1 countrycode using UEM.dta, nogen
merge 1:1 countrycode using MANF.dta, nogen
merge 1:1 countrycode using EDUC.dta, nogen
merge 1:1 countrycode using LE.dta, nogen
save final_dataset.dta, replace

graph twoway (lfit gdp savings) (scatter gdp savings)
graph twoway (lfit log_gdp savings) (scatter log_gdp savings)

reg log_gdp savings

reg log_gdp savings trade fdi unemployment manufacturing education

corr lifeexp savings, covariance

reg savings lifeexp trade fdi unemployment manufacturing education

ivreg log_gdp (savings = lifeexp) trade fdi unemployment manufacturing education

corr savings trade fdi unemployment manufacturing education

reg log_gdp savings trade fdi unemployment manufacturing education
hettest


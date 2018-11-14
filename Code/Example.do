* Load in the data
use "http://www.stata-press.com/data/r14/nhanes2d.dta", clear
codebook 
* Create a local variable of demographics
local demogvars race sex age
* Get summary stats in a loop
foreach myvar of varlist `demogvars' {
summ `myvar'
}


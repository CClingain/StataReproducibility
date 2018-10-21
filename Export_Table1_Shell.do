* Set working directory
cd "C:/Users/Clare/Documents/StataRepro/StataReproducibility"
* Load the data
use "http://www.stata-press.com/data/r14/lbw.dta", clear
* Run the regression
regress bwt smoke
return list

*Save results
mat temp = r(table)'
mat bweights = temp[1...,1.."se"]
mat pvalues = temp[1...,"pvalue"]
mat final = bweights , pvalues

* Export
putexcel set "Export_Tables.xlsx", sheet("Regression Shell Table 1") modify
putexcel B3  = matrix(final)
putexcel A30 = ("$S_TIME $S_DATE")


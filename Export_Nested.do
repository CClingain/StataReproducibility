* Set working directory
cd "C:/Users/Clare/Documents/StataRepro/StataReproducibility"
* Load the data
use "http://www.stata-press.com/data/r14/lbw.dta", clear


* Set up
local myreg1 bwt smoke                                                          // Insert regression equation #1
local myreg2 bwt smoke ht                                                       // Insert regression equation #2

matrix drop _all                                                                // Clear any matrices in memory

foreach counter of numlist 1/2{                                                 // For each value in my counter
	if `counter' == 1 {                                                         // if counter is set to 1
	regress `myreg1'                                                            // run the first regression
	mat temp = r(table)'                                                        // Save results temporarily in a matrix
	mat bweights = temp[1...,1.."se"]                                           // Extract the b-weights and standard errors
	mat pvalues = temp[1...,"pvalue"]                                           // Extract the p-values
	mat emptyrow = J(1,3,.)                                                     // Create an empty row that will take the place of the variable we are adding to the second equation (so our matrices are comformable)
	mat final`counter' = (bweights , pvalues) \ emptyrow                        // Combine all matrices for counter = 1
	}
	
	if `counter' == 2 {                                                         // if counter is set to 2
	regress `myreg2'                                                            // run the second regression
	mat temp = r(table)'                                                        // Save results temporarily in a matrix
	mat bweights = temp[1...,1.."se"]                                           // Extract the b-weights and standard errors
	mat pvalues = temp[1...,"pvalue"]                                           // Extract the p-values
	mat final`counter' = bweights , pvalues                                     // Combine all matrices for counter = 2
	}

	mat final = nullmat(final) , final`counter'                                 // Create the final matrix by combining each counter's matrix
	mat drop final`counter'                                                     // Drop to avoid repeats
	
}
mat list final                                                                  // View the results

* Export to Excel 
putexcel set "Export_Tables.xlsx", sheet("Regression Shell Table 2") modify
putexcel B3  = matrix(final)
putexcel A30 = ("$S_TIME $S_DATE")

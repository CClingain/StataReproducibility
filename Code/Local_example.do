************************************
***** Local variables practice *****
************************************

* Load in the data 
use "http://www.stata-press.com/data/r14/lbw.dta", clear

* Subset to mothers who are below average age
summ age
local agemean = r(mean)
* Note: you can subset in different ways! You can directly drop the data,
* or you can use conditional statements after each test. 
* Drop/keep/preserve can be tricky to use for reproducibility
* purposes, especially if the full data needs to be called back.

regress bwt smoke if age < `agemean'
regress bwt smoke lwt if age < `agemean'
regress bwt smoke lwt ht if age < `agemean'

* What if I wanted to have only 1 predictor, but to change the predictor?
summ age
local agemean = r(mean)                                                         // Save the mean age of mothers
local mypreds smoke lwt ht                                                      // Store the predictors of interest

foreach myvar of varlist `mypreds' {                                            // For each of my predictors
	regress bwt `myvar' if age < `agemean'                                      // Run a regression using mothers who are younger than the avg age
}

* If someone else had survey data predicting birth weight and wanted
* to run your models, now they can much more easily!

* If you want to get really extra, but super reproducible...
summ age
local agemean = r(mean)                                                         // Save the mean age of mothers
local mypreds smoke lwt ht                                                      // Store the predictors of interest
local mydv bwt                                                                  // Store the dependent variable

foreach myvar of varlist `mypreds' {                                            // For each predictor
	regress `mydv' `myvar' if age < `agemean'                                   // Run a regression on the DV with sample of mothers young than avg age
}

******************************
**** LaTeX Export Example ****
******************************

* Set working directory
cd "C:/Users/Clare/Documents/StataRepro/StataReproducibility"
* Load the data
use "http://www.stata-press.com/data/r14/lbw.dta", clear

* Install texdoc
capture which texdoc                                                            // Checks if texdoc is installed 
if _rc==111 ssc install texdoc.pkg                                              // If not installed, installs it 

* Initialize document
texdoc init Textable, replace
* Set tex parameters
tex \documentclass{article} 
tex \usepackage{stata} 
tex \begin{document}
tex \section{Table 1}
* Here is where the Stata code goes
texdoc stlog texlog
regress bwt smoke                                                               // Run regression 1
est store model1                                                                // Store results
mat temp = r(table)'                                                            // Save results temporarily in a matrix
mat bweights = temp[1...,1.."se"]                                               // Extract b-weights and standard errors
mat pvalues = temp[1...,"pvalue"]                                               // Extract p-values
mat final = bweights , pvalues                                                  // Combine b-weights and p-values into one matrix
mat li final                                                                    // Display final matrix

regress bwt smoke ht                                                            // Run regression 2
est store model2                                                                // Store results

estout model1 model2, cells(b(star fmt(3)) se(par fmt(2))) ///
  legend label varlabels(_cons constant) ///
  stats(r2 df_r, fmt(3 0) label(R-square df_residual))
  
texdoc stlog close
tex \end{document}
texdoc close
* One time only: save out stata style guide for LaTeX
*copy http://www.stata-journal.com/production/sjlatex/stata.sty stata.sty


* Export: run this in command line
*texdoc do texdoc_example

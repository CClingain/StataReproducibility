*** Estout Example ****

* Install estout
capture which estpost                                                           // Checks if estpost is installed 
if _rc==111 ssc install estout.pkg                                              // If not installed, installs it 

* Model 1
regress bwt age
est store model1

* Model 2
regress bwt age smoke
est store model2

* Model 3
regress bwt age smoke ptl
est store model3

* Make the table
estout model1 model2 model3, cells(b(star fmt(3)) se(par fmt(2))) ///
  legend label varlabels(_cons constant) ///
  stats(r2 df_r, fmt(3 0) label(R-square df_residual))


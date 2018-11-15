regress bwt smoke
return list
mat temp = r(table)'
mat list temp
putexcel set "Output/Export_Tables.xlsx", sheet("Regression Table 1") modify
putexcel A1 = matrix(temp)

putexcel A5 = matrix(temp), rownames

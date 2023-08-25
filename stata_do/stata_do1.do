pip install nbstata
python -m nbstata.install 

# or to update 
pip install nbstata --upgrade
---
title: Using Quarto for Stata dynamic documents
format: html
jupyter: nbstata
---
*| echo: fenced
sysuse auto, clear
describe
*| echo: fenced
 assert mpg > 0 & mpg < 100
*| echo: fenced
summarize weight
*| echo: fenced
*| output: asis
display "The variable weight has minimum value "  %4.2f `r(min)' " and " ///
         "has maximum value "   %4.2f `r(max)' "."
*| echo: fenced
*| output: asis
display "The variable weight has range "  %4.2f `r(max)'-`r(min)' "."
*| echo: fenced
scatter mpg weight, mcolor(blue%50)
*| echo: fenced
qui:graph export fig1.png, width(1600) replace
*| label: fig-cost
*| fig-cap: Price vs MPG
*| fig-subcap:
*|   - "Foreign Cars"
*|   - "Domestic Cars"
*| layout-ncol: 2
*| column: page  
*| echo: fenced

scatter price mpg if foreign==1, name(m1, replace) ylabel(0(4000)16000)
qui:graph export fig2a.png, width(1600) replace
scatter price mpg if foreign==0, name(m2, replace) ylabel(0(4000)16000)
qui:graph export fig2b.png, width(1600) replace
::: {#fig-mpgprice layout-ncol=2 .column-page }
![foreign](fig2a.png){#fig-mpgprice-1}
![domestic](fig2b.png){#fig-mpgprice-2}
Price vs MPG
:::

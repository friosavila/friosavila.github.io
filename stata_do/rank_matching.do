frause oaxaca, clear
drop if lnwage==.
capture program drop xx
program xx, eclass
** s1. Sep 2 groups
drop2 gx pscore pca lnw1 lnw2 ///
	  lnh1 lnh2 lnh3 lnh4 ///
	  lne1 lne2 lne3 lne4 ///
	  flnh1 flnh2 flnh3 flnh4 ///
	  flne1 flne2 flne3 flne4
	  
drop2 n1 n2 n3 n4

xtile gx = runiform(), n(2)

replace gx=gx-1
** s2. Estimate pscore pca and predicted
reg  gx educ  female age single married kids6 kids714
predict pscore,
pca educ   female age single married kids6 kids714, comp(1)
predict pca
reg exper educ  female age single married kids6 kids714 if gx==0
predict lnw1
reg exper educ   female age single married kids6 kids714 if gx==1
predict lnw2

bysort gx (pscore):gen n1=_n
gen lnh1=lnwage[n1] if gx==1
gen lne1=exper[n1] if gx==1
bysort gx (pc)	  :gen n2=_n
gen lnh2=lnwage[n2] if gx==1
gen lne2=exper[n2] if gx==1
bysort gx (lnw1)   :gen n3=_n
gen lnh3=lnwage[n3] if gx==1
gen lne3=exper[n3] if gx==1
bysort gx (lnw2)   :gen n4=_n
gen lnh4=lnwage[n4] if gx==1
gen lne4=exper[n4] if gx==1


foreach i in lnh1 lnh2 lnh3 lnh4 lne1 lne2 lne3 lne4{
	egen f`i'=mean(abs(lnwage-`i'))
}
matrix  b= flnh1[1], flnh2[1], flnh3[1], flnh4[1], ///
		   flne1[1], flne2[1], flne3[1], flne4[1]
ereturn post b

end


simulate  , reps(1000):xx

two kdensity _b_c1 || kdensity _b_c2 || kdensity  _b_c3 || kdensity  _b_c4, legend(order(1 "Pscore" 2 "PCA" 3 "PMM1" 4 "PMM2")) xtitle("RootMean squared error")
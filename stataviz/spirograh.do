clear
range th 0 20*_pi 999
 
gen x = 10 * cos(th+.5*_pi)
gen y = 10 * sin(th+.5*_pi)
drop2 x1 y1
gen x1 =x+ 5 * cos(-1.5*th+.5*_pi)
gen y1 =y+ 5 * sin(-1.5*th+.5*_pi)
drop2 x2 y2
gen x2 =x1+ 3 * cos(1.3*th+.5*_pi)
gen y2 =y1+ 3 * sin(1.3*th+.5*_pi)
scatter  y2 x2

gen t = _n/10
forvalues i = 0 (0.5) 200 {
	local lnx = floor(`i'*10)
	two line y x if t<=`i' || pci 0 0 `=y[`lnx']'  `=x[`lnx']' , ///
	aspect(1) xlabel(-10 10) ylabel(-10 10)
}

forvalues i = 0 (0.5) 200 {
	local lnx = floor(`i'*10)
	two line y1 x1 if t<=`i' || pci 0 0 `=y[`lnx']'  `=x[`lnx']' ///
	|| pci `=y[`lnx']'  `=x[`lnx']' `=y1[`lnx']'  `=x1[`lnx']' , ///
	aspect(1) xlabel(-10 10) ylabel(-10 10)
}


set graph off
forvalues i = 1(2)999 {
	local j = `j'+1
	local jj:display %04.0f `j'
	local lnx = floor(`i'*10)
	
	two line y2 x2 if t<=t[`i'], lw(1) || pci 0 0 `=y[`i']'  `=x[`i']' ///
											`=y[`i']'  `=x[`i']' `=y1[`i']'  `=x1[`i']' ///
											`=y1[`i']'  `=x1[`i']' `=y2[`i']'  `=x2[`i']' , lcolor(maroon*.5) lw(0.5)  ///
	aspect(1) xlabel(-20 20) ylabel(-20 20) ///
	legend(off) xscale(off) yscale(off)
	graph export sif`jj'.png, replace
}
set graph on

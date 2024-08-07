clear
set seed 1
 set obs 50
gen r1=runiformint(1,4)
gen r2=runiformint(1,4)
gen id=_n
sort r1  r2
mata:
r1=st_data(.,"r1")
r2=st_data(.,"r2")
rr1=J(rows(r1)*rows(r2),4,0)
k=0
for(i=1;i<=50;i++){
	for(j=1;j<=50;j++){
		if ((r1[i]==r1[j]) | (r2[i]==r2[j])) {
			k++
			rr1[k,]=(51-i,j,(r1[i]==r1[j]),(r2[i]==r2[j]) )			
		}
	}	
}
rr1=rr1[1..k,]

end
getmata rr1*=rr1, replace force

*set scheme white2
*color_style tableau
two (scatter rr11 rr12 if rr13==1,  ms(s) msize(2.1)) , aspect(1) ///
	legend(off)  xtitle("") ytitle("") yscale(off) xscale(off)
	
two (scatter rr11 rr12 if rr14==1,  ms(s) msize(2.1)), aspect(1) ///
	legend(off) ylabel("") xlabel("") yscale(off) xscale(off)
	
two (scatter rr11 rr12 if rr13==1,  ms(s) msize(2.1) color(%70)) ///
	(scatter rr11 rr12 if rr14==1,  ms(s) msize(2.1) color(%70)), aspect(1) ///
	legend(off) ylabel("") xlabel("") yscale(off) xscale(off)
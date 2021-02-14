#!/bin/awk -f
function getgp(year,grade,credit) {
	if (strtonum(year) >= 2020) {
		MAP["A"]=4; MAP["B"]=3; MAP["C"]=2; MAP["D"]=1; MAP["+"]=.3; MAP["-"]=-.3
	}
	else {
		MAP["A"]=4; MAP["B"]=3; MAP["C"]=2; MAP["D"]=1; MAP["F"]=0; MAP["+"]=.5
	}
	if (length(grade)==1)
		return credit*MAP[grade]
	else
		return credit*(MAP[substr(grade,1,1)]+MAP[substr(grade,2,1)])
}
BEGIN {
	gp=0
	credit=0
	split("", prev)
	printf "Year    Subject Credit Grade   GP\n"
}
{
	if ($2 != prev[2] && strtonum($1) < strtonum(prev[1]))
		printf "%4d %10s %6d %5s %3.1f\n",$1,$2,$3,$4,getgp($1,$4,$3)
	else {
		printf "%4d %10s %6d %5s %3.1f retake\n",$1,$2,$3,$4,getgp($1,$4,$3)
		gp-=getgp(prev[1],prev[4],prev[3])
        credit-=prev[3]
	}
	split($0, prev)
	gp+=getgp($1,$4,$3)
	credit+=$3
}
END {
	printf("Credits %3d\n", credit)
	printf("GPA:   %3.2f\n\n", gp/NR)
}

proc import out= work.recipes
DATAFILE= ""
DBMS=CSV REPLACE;
GETNAMES=yes;
DATAROW=2;
run;

proc iml;
use recipes;
read all var{

} into M;
close;
print M;
dotM = j(nrow(m),nrow(m),0); print dotM;
temp=M[1,]*t(M[2,])/(nrom(M[1,])*nrom(M[2,]));
print temp;

do i=1 to nrow(M);
do j=1 to nrow(M);
dotM[i,j]=M[i,]*t(M[j,])/(nrom(M[i,])*norm(M[j,]));
end;
end;
print dotM;

**** Jaccard Distance ****;
m2=t(m); print M2;

inter=t(M2[,3])*M2[,4]; print inter;
add= M2[,3]+M2[,4]; print add;
union=add[+,]-inter;print union;
jaccard = j(ncol(M2),ncol(M2),0); print Jaccard;
Distance = j(ncol(M2),ncol(M2),0); print Distance;
do i=1 to ncol(M2);
do j=1 to ncol(M2);
inter=t(M2[,i])*M2[,j]; print inter;
add= M2[,i]+M2[,j];
union=add[+,]-inter; *print union;
jaccard[i,j]=(inter/union);
Distance[i,j]=1-(inter/union);
end;
print jaccard;
print Distance;
quit;

proc distance data=RECIPES out=Cos_out method=COSINE shape=square;
var ratio (

);
id RECIPE;
run;

proc distance data=RECIPES out=distjacc_out method=djaccard absent=0 shape=square;
var anominal(

);
id RECIPE;;
run;

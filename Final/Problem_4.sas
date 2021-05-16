*-------------------------------------------------------------------------;
* Project        :  CS593-Data Mining II Final Exam                       ;
* Developer(s)   :  Yueyang Tao, 10458455                                 ;
* Comments       :  Solution for the Problem 4                            ;
*-------------------------------------------------------------------------;

/*libname sasdata "O:\CS-593\SAS_data";

proc copy in=sasdata out=work;
    select admission;
run;*/

proc import out= work.admission
DATAFILE= "O:\CS-593\Raw_data\admission.csv"
DBMS=CSV admission;
GETNAMES=yes;
DATAROW=2;
run;

data admission;
infile datalines;
input Costomer_ID $ Article1 Article2 Article3 Article4	;
*rating=rating*.20;
datalines;
A	0	1	0	1
B	0	1	1	1
C	1	0	1	0
D	1	0	0	1
E	1	0	0	0
;
run;
proc iml;
 use  admission ;
  read all var{Article1 Article2 Article3 Article4} into M;
  print M;
  jaccard = j(4, 4, 0); print Jaccard;
  inter=t(M[,1])* M[,2]; print inter;
   add= M[,1]+M[,2]; print add;
   union=add[+,];print union;
   jaccard[1,2]=inter/(union-inter); print jaccard; 
  do i=1 to 4; 
    do j=1 to 4; 
      inter=t(M[,i])* M[,j];  
      add= M[,i]+M[,j];
      union=add[+,]; 
     jaccard[i,j]=inter/(union-inter); 
	end;
  end;
  print jaccard;
  quit;


proc iml;
use admission;
read all var{
Article1 Article2 Article3 Article4
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

proc distance data=admission out=Cos_out method=COSINE shape=square;
var ratio (
Article1 Article2 Article3 Article4
);
id adission;
run;

proc distance data=admission out=distjacc_out method=djaccard absent=0 shape=square;
var anominal(
Article1 Article2 Article3 Article4
);
id admission;;
run;

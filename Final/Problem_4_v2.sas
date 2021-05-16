*-------------------------------------------------------------------------;
* Project        :  CS593-Data Mining II Final Exam                       ;
* Developer(s)   :  Yueyang Tao, 10458455                                 ;
* Comments       :  Solution for the Problem 4                            ;
*-------------------------------------------------------------------------;


libname sasdata "O:\CS-593\SAS_data";
proc copy in=sasdata out=work;
    select admission;
run;

/*proc import out= work.admission
DATAFILE= "O:\CS-593\Raw_data\admission.csv"
DBMS=CSV admission;
GETNAMES=yes;
DATAROW=2;
run;*/

/**** Jaccard Similarity ****/

data admission;
infile datalines;
input Costomer_ID $ Article1 Article2 Article3 Article4	;
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


/**** Cosine  Similarity****/

data admission;
infile datalines;
input Article1 Article2 Article3 Article4;

datalines;
0 1 0 1
0 1 1 1
1 0 1 0
1 0 0 1
1 0 0 0
;
run;
 
 
 
/*proc sgplot data=admission aspect=1;
   vector x=x y=y / datalabel=Article datalabelattrs=(size=14);
   xaxis grid;  yaxis grid;
run;*/


 proc iml;
 use  admission;
 read all var{Article1 Article2 Article3 Article4} into M;
 close;
 print M;

 dotM = j(nrow(m), nrow(m)-1, 0); print dotM  ;
 temp=M[1,]*t(M[1,])/(norm(M[1,]) *norm(M[1,]));
 print temp;


 do i=1 to 4;
  do j=1 to 4;
       dotM[i,j]=M[i,]*t(M[j,])/(norm(M[i,]) *norm(M[j,]) ); 
  end;
 end; 
 print dotM ; 

  
 quit;

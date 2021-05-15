

data Vectors;
length Name $1;
input Name x y;
datalines;
A  0.5 1
B  3   5
C  3   2.8
D  5   1
;
run;
 
 
 
proc sgplot data=Vectors aspect=1;
   vector x=x y=y / datalabel=Name datalabelattrs=(size=14);
   xaxis grid;  yaxis grid;
run;

proc distance data=Vectors out=Cos method=COSINE shape=square;
   var  ratio(x y);
   id Name;
run;

   proc iml;
 use  Vectors;
 read all var{x y} into M;
 close;
 print M;



 
   proc iml;
 use  Vectors;
 read all var{x y} into M;
 close;
 print M;
 dotM = j(nrow(m), nrow(m), 0); print dotM  ;
 temp=M[1,]*t(M[2,])/(norm(M[1,]) *norm(M[2,]) );
  print temp;


 do i=1 to nrow(M);
  do j=1 to nrow(M);
       dotM[i,j]=M[i,]*t(M[j,])/(norm(M[i,]) *norm(M[j,]) ); 
  end;
 end; 
 print dotM ; 






 /*
 size = j(nrow(m),1, 0);print size;

 do i=1 to nrow(M);
    normM=norm(M[i,]);
	size[i,1]=normM;
   print normm;
 end;
 print size;
*/
 dotM = j(nrow(m), nrow(m), 0); print dotM  ;
 do i=1 to nrow(M);
  do j=1 to nrow(M);
    *dot=M[i,]*t(M[j,]);*print dot;
     *normij=norm(M[i,]) *norm(M[j,]);
	 *print normij;
    dotM[i,j]=M[i,]*t(M[j,])/(norm(M[i,]) *norm(M[j,]) ); 
  end;
 end; 
 print dotM ; 
 quit;


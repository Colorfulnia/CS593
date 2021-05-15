data content;
infile datalines;
input Movie $ Actor1 Actor2	Actor3	Actor4	Actor5	Actor6	Rating;
*rating=rating*.20;
datalines;
A	1	0	0	1	1	0	5
B	1	1	1	0	0	0	4
C	0	0	0	1	1	1	2
D	0	1	0	0	0	0	4
;
run;

 proc iml;
 use  content;
 read all var{Actor1 Actor2	Actor3	Actor4	Actor5	Actor6	Rating } into M;
 close;
 print M;
 dotM = j(nrow(m), nrow(m), 0); print dotM  ;
 dist_A_B=M[1,]*t(M[2,])/(norm(M[1,]) *norm(M[2,]) );
  print dist_A_B ;
  dist_A_C=M[1,]*t(M[3,])/(norm(M[1,]) *norm(M[3,]) ); 
  print dist_A_C;

 do i=1 to nrow(M);
  do j=1 to nrow(M);
       dotM[i,j]=M[i,]*t(M[j,])/(norm(M[i,]) *norm(M[j,]) ); 
  end;
 end; 
 print dotM ; 
 quit;

data original;
infile datalines;
input Customer $ Movie1 Movie2 Movie3 Movie4 Movie5 Movie6 Movie7;
datalines;
A	4	0	0	5	1	0	0
B	5	5	4	0	0	0	0
C	0	0	0	2	4	5	0
D	0	3	0	0	0	0	3
;
run;

 proc iml;
 use  Original;
 read all var{Movie1 Movie2 Movie3 Movie4 Movie5 Movie6 Movie7} into M;
 close;
 print M;
 dotM = j(nrow(m), nrow(m), 0); print dotM  ;
 dist_A_B=M[1,]*t(M[2,])/(norm(M[1,]) *norm(M[2,]) );
  print dist_A_B ;
  dist_A_C=M[1,]*t(M[3,])/(norm(M[1,]) *norm(M[3,]) ); 
  print dist_A_C;


 do i=1 to nrow(M);
  do j=1 to nrow(M);
       dotM[i,j]=M[i,]*t(M[j,])/(norm(M[i,]) *norm(M[j,]) ); 
  end;
 end; 
 print dotM ; 
 quit;

data rounded;
infile datalines;
input Customer $ Movie1 Movie2 Movie3 Movie4 Movie5 Movie6 Movie7;
datalines;
A	1	0	0	1	0	0	0
B	1	1	1	0	0	0	0
C	0	0	0	0	1	1	0
D	0	1	0	0	0	0	1
;
run;

proc iml;
 use  rounded;
 read all var{Movie1 Movie2 Movie3 Movie4 Movie5 Movie6 Movie7} into M;
 close;
 print M;
 dotM = j(nrow(m), nrow(m), 0); print dotM  ;
 dist_A_B=M[1,]*t(M[2,])/(norm(M[1,]) *norm(M[2,]) );
  print dist_A_B ;
  dist_A_C=M[1,]*t(M[3,])/(norm(M[1,]) *norm(M[3,]) ); 
  print dist_A_C;


 do i=1 to nrow(M);
  do j=1 to nrow(M);
       dotM[i,j]=M[i,]*t(M[j,])/(norm(M[i,]) *norm(M[j,]) ); 
  end;
 end; 
 print dotM ; 
 quit;

data Normalized;
infile datalines;
input Customer $ Movie1 Movie2 Movie3 Movie4 Movie5 Movie6 Movie7;
datalines;
A	0.666666667	0	0	1.666666667	-2.333333333	0	0
B	0.333333333	0.333333333	-0.666666667	0	0	0	0
C	0	0	0	-1.666666667	0.333333333	1.333333333	0
D	0	0	0	0	0	0	0
;
run;

proc iml;
 use  Normalized;
 read all var{Movie1 Movie2 Movie3 Movie4 Movie5 Movie6 Movie7} into M;
 close;
 print M;
 dotM = j(nrow(m), nrow(m), 0); print dotM  ;
 dist_A_B=M[1,]*t(M[2,])/(norm(M[1,]) *norm(M[2,]) );
  print dist_A_B ;
  dist_A_C=M[1,]*t(M[3,])/(norm(M[1,]) *norm(M[3,]) ); 
  print dist_A_C;


 do i=1 to nrow(M);
  do j=1 to nrow(M);
       dotM[i,j]=M[i,]*t(M[j,])/(norm(M[i,]) *norm(M[j,]) ); 
  end;
 end; 
 print dotM ; 
 quit;




data shingles;
infile datalines;
input shingle1 shingle2  shingle3 shingle4 shingle5 shingle6 ;

datalines;
1	0	0	1	1	0	 
1	1	1	0	0	0	 
0	0	0	1	1	1	 
0	1	0	0	0	0	 
;
run;

proc iml;
 use  shingles;
  read all var{shingle1 shingle2  shingle3 shingle4 shingle5 shingle6} into M;
  print M;
  jaccard = j(6, 6, 0); print Jaccard;
  inter=t(M[,1])* M[,1]; print inter;
   add= M[,1]+M[,1]; print add;
   union=add[+,];print union;
   jaccard[1,1]=inter/(union-inter); print jaccard; 

  do i=1 to 6; 
    do j=1 to 6; 
      inter=t(M[,i])* M[,j];  
      add= M[,i]+M[,j];
      union=add[+,]; 
     jaccard[i,j]=inter/(union-inter); 
	end;
  end;
  print jaccard;
  quit;

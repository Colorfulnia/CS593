


data content_jaccard;
infile datalines;
input Movie $ Actor1 Actor2	Actor3	Actor4	Actor5	Actor6	;
*rating=rating*.20;
datalines;
A	1	0	0	1	1	0
B	1	1	1	0	0	0
C	0	0	0	1	1	1
D	0	1	0	0	0	0
;
run;


proc iml;
 use  content_jaccard ;
  read all var{Actor1 Actor2	Actor3	Actor4	Actor5	Actor6} into M;
  print M;
  jaccard = j(6, 6, 0); print Jaccard;
  inter=t(M[,1])* M[,2]; print inter;
   add= M[,1]+M[,2]; print add;
   union=add[+,];print union;
   jaccard[1,2]=inter/(union-inter); print jaccard; 

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

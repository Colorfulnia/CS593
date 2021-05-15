




data Arcs;
    infile datalines;
    input Node $ A B C D E F G  ;
    datalines;
A	0	1	1	0	0	1	0	
B	1	0	0	1	0	0	1	
C	0	0	0	1	0	1	0	
D	1	1	0	0	1	0	0	
E	0	0	1	0	0	0	0	
F	0	0	0	0	1	0	0	
G	0	1	0	0	0	0	0	
;
run;

proc iml;
   use arcs;
   read all  var {A B C D E F G } into links;
   print links;
   col_total=links[+,]; print col_total;
   M=links/col_total; print M;
   row_cnt=nrow(M); print row_cnt;
   rank_p=repeat( 1/row_cnt,row_cnt, 1);print rank_p;
   rank_p50=(M**50)*rank_p;
   print rank_p50 ;

quit;


data Arcs;
    infile datalines;
    input Node $ A B C D E F G  ;
* $ A 	B 	C 	D 	E 	F 	G  ;
    datalines;
A	0	1	1	0	0	1	0	
B	1	0	0	1	0	0	0	
C	0	0	0	1	0	1	0	
D	1	1	0	0	1	0	0	
E	0	0	0	0	0	0	0	
F	0	0	0	0	1	0	0	
G	0	1	0	0	0	0	0	
;
run;

proc iml;
   use arcs;
   read all  var {A B C D E F G } into links;
   print links;
   col_total=links[+,]; print col_total;
   *** reset the seventh column ***;
   links[,7]=1; print links;
   col_total=links[+,]; print col_total;
   M=links/col_total; print M;
   row_cnt=nrow(M); print row_cnt;
   rank_p=repeat( 1/row_cnt,row_cnt, 1);print rank_p;
   rank_p50=(M**50)*rank_p;
   print rank_p50 ;

quit;



proc iml;
   use arcs;
   read all  var {A B C D E F G } into links;
   print links;
   col_total=links[+,]; print col_total;
   *** reset the seventh column ***;
   links[,7]=1; print links;
   col_total=links[+,]; print col_total;
   M=links/col_total; print M;
   row_cnt=nrow(M); print row_cnt;
   rank_p=repeat( 1/row_cnt,row_cnt, 1);print rank_p;
   rank_p2=.80*M*rank_p+.20*rank_p; print rank_p2; 
   rank_p3=.80*M*rank_p2+.20*rank_p2; print rank_p3; 
   
quit;









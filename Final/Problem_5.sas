*-------------------------------------------------------------------------;
* Project        : CS593 Data Mining II Final Exam                        ;
* Developer(s)   : Yueyang Tao, 10458455                                  ;
* Comments       : Soluition to Problem 5                                 ;
*                                                                         ;
*-------------------------------------------------------------------------;


DATA arcs1;
 INPUT Node $ A B C D E F G;
CARDS;
A 0 1 0 0 1 1 0 
B 1 0 1 0 0 0 1
C 0 1 0 1 0 0 0
D 0 0 1 0 1 0 0
E 1 0 0 1 0 1 1
F 1 0 0 0 1 0 0
G 1 0 1 1 0 1 ？

;
run;

proc iml;
   use arcs1;
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

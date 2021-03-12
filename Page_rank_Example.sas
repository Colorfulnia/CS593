
/****************************************************************** 
• First Name: Khasha  
• Last Name : Dehnadd   
• Pagerank in SAS   
• Student Version 1   
•   
 ******************************************************************/



proc iml;
       
      M= {0     .5  1   0  ,
	     .3333    0  0  .5 ,
		 .3333    0  0  .5 ,
		 .3333   .5  0   0 }
		;
	  print M;

	  rank_p1={.25 .25 .25 .25};
      print rank_p1 ; 
    
    rank_p = t(rank_p1);
	*rank_p=rank_p1`;
    print rank_p ; 
  
    
    rank_p2=M *rank_p;
    print rank_p2 ;     
   rank_p50=(M**50)*rank_p;
   print rank_p50 ;

   rank_p100=(M**100)*rank_p;
   print rank_p100 ;

quit;

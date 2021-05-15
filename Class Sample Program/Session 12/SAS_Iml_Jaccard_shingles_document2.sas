/****************************************************************** 
• Name: Khasha Dehnad 
• Purpose: Measuring the Jaccard simmilarity of two documents.
• SAS Program: iml_jaccard  
• Date:   
• Description:
• Program Dependencies: Single_mac.sas 
• Data Dependencies:   
 ******************************************************************/





proc copy in=sasdata out=work;
select shingles_all;
run; 

proc iml;
  use  sasdata.shingles_all;
  read all var{val1 val2 val3 val4} into M;
  *print M;
  jaccard = j(4, 4, 0); print Jaccard;
  do i=1 to 4; 
    do j=1 to 4; 
      inter=t(M[,i])* M[,j]; print inter;
      add= M[,i]+M[,j];
      union=add[+,];*print union;
     jaccard[i,j]=inter/(union-inter); 
	end;
  end;
  print jaccard;
  quit;
   ;
 
  


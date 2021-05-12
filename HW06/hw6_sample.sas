/****************************************************************** 
*Name: Huajie Xu
*Purpose: Calculate the Jaccard and cosine similarities
*Date:
*Description: 
*
*I pledge my honor that I have abided by the Stevens Honor System.  
*******************************************************************/

libname sasdata "/folders/myfolders/sasuser.v94/SAS_data/";
proc copy in=sasdata out=work;
   select recipes;
run;

/* Jaccard */
proc distance data=recipes method=djaccard absent=0 out=recipe_d;
   var anominal(Tomato--Sugar);
   id Recipe;
run;

proc print data=recipe_d;
run;

/* Cosine */
proc iml;
 use recipes;
 read all var{Tomato Garlic Salt Onion TomatoPaste OliveOil Celery Broth GreenPepper Cumin Flour BrownSugar BayLeaf GroundBeef BlackPepper ChiliPowder Cilantro Carrot CayennePepper Oregano Oil Parsley PorkSausage RedPepper Paprika Thyme Tomatillo JalapenoPepper WorcestershireSauce Lime Eggplant GreenOlives Capers Sugar } into M;
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

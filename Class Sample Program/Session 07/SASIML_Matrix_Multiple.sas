
proc iml;
   M={1   2   3   4,
      5   6   7   8,
	  9   10  11  12,
	  13  14  15  16,
	  17  18  19  20};

  print M;

   v1={ 21 22 23 24}; print v1;
   v=t(v1); print v;

   Result=M*V; print Result;

   MCol_1_2=M[,{1 2}];print MCol_1_2 ;
   MCol_3_4=M[ ,{3,4}]; print   MCol_3_4;
   VRow_1_2=V[{1 2},]; print VRow_1_2;
   VRow_3_4=V[{3 4},]; print VRow_3_4;

   MR_1_2=MCol_1_2*VRow_1_2; print MR_1_2;
   MR_3_4=MCol_3_4*VRow_3_4; print MR_3_4;
   Result2=MR_1_2+MR_3_4; print  Result2;
   print Result;
quit;

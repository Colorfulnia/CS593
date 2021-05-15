
proc iml;
M=
{11	12	13	14	15	16 ,
 21	22	23	24	25	26 ,
 31	32	33	34	35	36 ,
 41	42	43	44	45	46 ,
 51	52	53	54	55	56 ,
 61	62	63	64	65	66 ,
 71	72	73	74	75	76 ,
 81	82	83	84	85	86};

  print M;

  v={
     	111	112,
		121	122,
		131	132,
		141	142,
		151	152,
     	161	162};

  print v;

   Result=M*V; print Result;

   MCol_1_2=M[,{1 2}];print MCol_1_2 ;
   MCol_3_4=M[ ,{3,4}]; print   MCol_3_4;
   MCol_5_6=M[ ,{5,6}]; print   MCol_5_6;
   VRow_1_2=V[{1 2},]; print VRow_1_2;
   VRow_3_4=V[{3 4},]; print VRow_3_4;
   VRow_5_6=V[{5 6},]; print VRow_5_6;

   MR_1_2=MCol_1_2*VRow_1_2; print MR_1_2;
   MR_3_4=MCol_3_4*VRow_3_4; print MR_3_4;
   MR_5_6=MCol_5_6*VRow_5_6; print MR_5_6;
   Result2=MR_1_2+MR_3_4+ MR_5_6; print  Result2;
   print Result;
quit;

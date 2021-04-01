
data full_matrix;
infile datalines;
    input row  col1 col2 col3  col4 col5 col6 col7 col8 col9 ;
    datalines;
1	0	2	3	0	0	4	0	0	0
2	1	0	0	3	0	0	0	0	0
3	0	0	0	4	0	1	0	0	0
4	2	1	0	0	3	0	0	0	0
5	0	0	0	0	0	0	0	0	0
6	0	0	0	0	3	0	0	0	0
7	0	4	0	0	0	0	0	0	0
8	0	0	0	0	0	0	2	0	3
9	0	0	0	0	0	0	0	5	0
;
run;

data full_vector;
infile datalines;
  input V_row v_value;
datalines;
1 3
2 4
3 0
4 0
5 0
6 5
7 0
8 6
9 5
;
run;
proc iml;
  use full_matrix;
  read all var { col1 col2 col3  col4 col5 col6 col7 col8 col9} into FM;
  close  full_matrix;
  print FM;

  use full_vector;
  read all var {v_value} into FV; print FV;

  FM_FV=FM*FV; print FM_FV;
quit;



data sparse_matrix;
keep r_no c_no M_element;
array cols{9} col1 - col9;
set full_matrix;
do i=1 to 9;
   r_no=row ;
  c_no=i;
   M_element=cols{i}; 
  if cols{i}>0 then output;
end;
run; 

data sparse_vector;
  keep v_row  V_element;
  set full_vector;
  if v_value>0 then do;
     V_element=V_value;
     output;
  end;
run;

proc sql;
  create table M_V_product_temp as 
  select r_no, c_no,  M_element  , v_row, V_element   
         , M_element *V_element as product
	from   sparse_matrix A
	     ,sparse_vector B
   Where A.c_no= B.v_row
   and r_no=1
   ;
quit;

proc sql;
  create table M_V_product as 
  select  r_no as MV_row   
         , sum(M_element *V_element) as  MV_element
	from   sparse_matrix A
	     ,sparse_vector B
   Where A.c_no= B.v_row
   group by   r_no
   order by  r_no
   ;
quit;



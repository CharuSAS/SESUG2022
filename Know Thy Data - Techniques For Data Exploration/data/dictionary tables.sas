
%let path = C:\Users\cancxs\OneDrive - SAS\Home\user groups\2022 UG\SESUG 21-25 Oct 22\Know Thy Data - LRNSAS4\data;
libname diabetes "&path";


*2. what are dictionary tables;

*2.1 Examine dictionary tables;
proc sql ;
select distinct memname, memlabel
from dictionary.dictionaries;
quit;

*2.2 find common columns to do your joins;
proc sql;
select name, memname, type, length
from dictionary.columns
where libname ='DIABETES' and upcase(name) contains 'ID';
quit;

proc sql;
select name, memname, type, length
from dictionary.columns
where libname ='DIABETES' 
group by name
having count(name) > 1
order by name;
quit;
*2.3 an efficiency question - PROC SQL or not;
options fullstimer;
proc sql;
select libname, memname, name, type, length
from dictionary.columns
where libname ='DIABETES' and upcase(name) contains 'ID';
quit;
proc print data=sashelp.vcolumn label noobs;
var  libname memname name type length;
where  libname ='DIABETES' and   upcase(name) contains 'ID';
run;
options nofullstimr;

/*2.4 Put Variables Into Alpha Order*/

proc print data=diabetes.pima;
var dbp--id;
run;
proc contents data=diabetes.pima varnum;
run;

proc sql noprint;
select name into :newname separated by ","
from dictionary.columns
where libname ='DIABETES' and 
upcase(memname) ='PIMA'
order by name;
quit;
proc sql;
create table ordered as
select &newname
from diabetes.Pima;
quit;
proc contents data=ordered varnum;
run;

*2.5 find all variable type conflicts globally;
proc sql ;
select libname, memname, name, type, length
from dictionary.columns
where upcase(name) contains 'ID' and libname='DIABETES'
group by name
having count(distinct type) > 1
order by 1, 2
;
quit;


/*2.6 identify working directory & a cool SAS option;*/

options symbolgen;
%macro CurrDir;
filename _temp '.';
%global Current;
proc sql ;
select xpath into :Current TRIMMED
from dictionary.extfiles
where fileref = '_TEMP';
quit;
filename _temp clear;
%put _user_;
%mend;
/* no ending semicolon on macro calls!!! */
%currdir

%put **&current**;
*when you create macro variables via SQL it preserves Leading and trailing blanks. 
The following assignment statement will trim leading and trailing blanks;
/*%let current=&current;*/

%include "&current\alloptions.sas" ;
title "Notice no date which was the alloptions program that was being called
by the %include statement";
proc print data=diabetes.pima;
run;




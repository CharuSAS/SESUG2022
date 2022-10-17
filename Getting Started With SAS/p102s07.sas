 /********************************************************************/
 /* This program uses an INFILE statement to read a raw data file.   */
 /* The INFILE statement includes a full path for Microsoft Windows. */
 /*                                                                  */
 /* For UNIX or SAS onDemand:                                        */
 /*      Replace  the INFILE statement with the following statement: */
 /*               infile "&path/country.dat" dlm='!';                */
 /*                                                                  */
 /* For  z/OS:                                                       */
 /*      Replace  the INFILE statement with the following statement: */
 /*               infile "&path..rawdata(country)" dlm='!';          */
 /********************************************************************/

data work.country2;
   length Country_Code $ 2 Country_Name $ 48;
   infile "&path\country.dat" dlm='!'; 
   input Country_Code $ Country_Name $;
run;

proc print data=work.country2;
	var Country_Code Country_Name;
run;

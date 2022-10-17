/*********************************************************
*  1. After the DATA step, add a PROC CONTENTS step to   *
*     view the descriptor portion of work.donations.     *                         
*  2. Submit the program and review the results.         *
*  3. How many observations are in the data set?         *
*********************************************************/

 /********************************************************************/
 /* This program uses an INFILE statement to read a raw data file.   */
 /* The INFILE statement includes a full path for Microsoft Windows. */
 /*                                                                  */
 /* For UNIX or SAS onDemand:                                        */
 /*      Replace  the INFILE statement with the following statement: */
 /*               infile "&path/donation.dat";                       */
 /*                                                                  */
 /* For  z/OS:                                                       */
 /*      Replace  the INFILE statement with the following statement: */
 /*               infile "&path..rawdata(donation)";                 */
 /********************************************************************/

data work.donations;
   infile "&path\donation.dat"; 
   input Employee_ID Qtr1 Qtr2 Qtr3 Qtr4;
   Total=sum(Qtr1,Qtr2,Qtr3,Qtr4);
run;

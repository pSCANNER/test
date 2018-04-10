/*System Options*/
options mprint linesize=150 pagesize=50 compress=yes reuse=no symbolgen ERRORS=0 noquotelenmax validvarname=v7 LRECL=32767;

/***********************/
/*    User Inputs      */
/***********************/

/*
1) Edit DMID and Site ID 
*/
%LET DMID=C3;
%LET SITEID=USC;

   /*-------------------------------------------------------------------*\
   ||                                                                   ||
   ||  DATA PARTNERS                                 DMID      SITEID   ||
   ||  -----------------------------------------------------------------||
   ||  Cook County								    C9          CC   	||
   ||  Loyola Medicine								C9			LM		||
   ||  Lurie Children's								C9			LC		||
   ||  Northshore									C9			NS		||
   ||  Northwestern Medicine						C9			NW		||
   ||  Rush											C9			RU		||
   ||  U of Chicago									C9			UC		||
   ||  U of Illinois								C9			UI		||
   ||  Alliance Chicago								C9			AC		||
   ||  ADVANCE      								C10			ADV		||
   ||  Children's Mercy								C4			CMH    	||
   ||  Indiana U Regenstief							C4          REG 	||
   ||  Marshfield Clinic							C4			MCRF	||
   ||  Med Coll Wisconsin							C4			MCW		||
   ||  U of Iowa									C4			UI      ||
   ||  U of Kansas                                  C4          UK		||
   ||  U of Minnesota AHC 							C4			UMA		||
   ||  U of Missouri HC								C4			UMO		||
   ||  U of Nebraska								C4			UN		||
   ||  UT HSC San Antonio							C4			UTHSCSA ||
   ||  UT SW Med Ctr								C4			UTSW	||
   ||  UW Madison									C4			UWM		||
   ||  Allina Health								C12			AH		||
   ||  Arizona State U								C12			ASU		||
   ||  Essentia Health								C12			EH		||
   ||  Intermountain HC								C12			IHC		||
   ||  Mayo Clinic									C12			MC		||
   ||  Ohio State U									C12			OSU		||
   ||  U of Michigan								C12			UMI		||
   ||  DUKE											C2			DUKE	||
   ||  Health Science SC							C2			HSSC	||
   ||  Meharry										C2			MEH		||
   ||  UNC											C2			UNC		||
   ||  Vanderbilt									C2			VAN		||
   ||  VHAN											C2			VHAN	||
   ||  NYGC											C8			NYC		||
   ||  OneFlorida									C13			OF		||
   ||  Geisinger									C11			GS		||
   ||  Johns Hopkins								C11         JHU		||
   ||  Penn State Med Ctr							C11			PSH		||
   ||  Temple University 							C11			TU		||
   ||  UPMC Claims									C11			UPMC2	||
   ||  UPMC											C11			UPMC 	||
   ||  Cincinnati Children's						C7			CCHMC	||
   ||  PEDSnet										C7			CPED	||
   ||  Denver Health								C5			DH		||
   ||  Health Partners								C5			HP		||
   ||  KPCO											C5			KPCO	||
   ||  KPMA											C5			KPMA    ||
   ||  KPWA											C5          KPWA    ||
   ||  KPNC											C5			KPNC	||
   ||  KPNW											C5			KPNW	||
   ||  KPSC											C5			KPSC	||
   ||  Cedars Sinai									C3			CS		||
   ||  San Mateo Med Ctr						    C3          SM		||
   ||  UC Davis										C3			UCD		||
   ||  UC Irvine									C3			UCI		||
   ||  UCSD											C3			UCSD	||
   ||  VA-Vinci										C3          VAV		||
   ||  Baylor SW North								C6			BAY		||
   ||  Ochsner										C6			OCH		||
   ||  Pennington/LSU								C6			PLSU	||
   ||  Tulane										C6			TUL		||
   ||  Beth Israel									C1			BID		||
   ||  Boston Children's							C1			BCH		||
   ||  Boston Medical								C1			BMC		||
   ||  Grady										C1			GRD		||
   ||  Morehouse									C1			MHS		||
   ||  Partners Health								C1			PHS		||
   ||  UTHealth										C1			UTH		||
   ||  Wake Forest									C1			WF	    ||
   ||  UCLA											C3			UCLA    ||
   ||  Wash U BJC									C1			WU      ||
   ||  USC										    C3			USC	    ||
   ||  UCSF     									C3          UCSF    ||
	\*-------------------------------------------------------------------*/ 
/*
2) Edit this section to reflect your name for each Table/File (or View)
*/
   
%let ENRTABLE=;			             /*Not needed for this request*/
%let DEMTABLE=demographic;
%let DISTABLE=;			             /*Not needed for this request*/
%let DIATABLE=diagnosis;
%let PROCTABLE=;         			 /*Not needed for this request*/
%let ENCTABLE=encounter;
%let VITTABLE=;						 /*Not needed for this request*/
%let PRESCTABLE=; 					 /*Not needed for this request*/
%let LABTABLE=;						 /*Not needed for this request*/
%let DEATHTABLE=;					 /*Not needed for this request*/



/*
3) Edit this section to define the macro parameters;
*/

*Values below the THRESHOLD parameter will be considered as low cell count.;
*If left empty, the program will assign a default value of 11; 
%let THRESHOLD=11;
*select Y if you want the attrition table to be populated in the DRNOC folder and report or N if you
 wish to opt out;
%let ATTRITIONTABLE=Y;

/*
4) Edit this section to reflect locations for the libraries/folders for PCORNET Data 
   and Output folders
*/
/********** FOLDER CONTAINING INPUT DATA FILES AND MSCDM DATA ***************************************/
/* IMPORTANT NOTE: end of path separators are needed;                                               */
/*   Windows-based platforms:    "\", e.g. "C:\user\sas\" and not "C:\user\sas";                    */
/*   Unix-based platforms:      "/", e.g."/home/user/sas/" and not "/home/user/sas";                */
/*                                                                                                  */
/********** FOLDER CONTAINING INPUT DATA FILES AND MSCDM DATA ***************************************/;
/*Data in MSCDM Format*/          libname indata '/schaeffer-a/sch-projects/dua-data-projects/PSCANNER/data/pcornet_1_24_18/';  
								   
/*NDC/ICD9 Codes File Location*/  %LET infolder=/schaeffer-a/sch-projects/dua-data-projects/PSCANNER/svnfiles/pcori_trunk/pcori_reports/rcr_pmp1_wp001_nsd2_v01/infolder/;								  
/*SAS Output Files*/              libname infolder "&infolder.";

/*Macro Files Location*/          %let sasmacr=/schaeffer-a/sch-projects/dua-data-projects/PSCANNER/svnfiles/pcori_trunk/pcori_reports/rcr_pmp1_wp001_nsd2_v01/infolder/macros/;

/********** FOLDER CONTAINING SUMMARY FILES TO BE EXPORTED TO OPERATION CENTER (DRNOC)*/;
/*CSV Output Files*/              %LET DRNOC=/schaeffer-a/sch-projects/dua-data-projects/PSCANNER/svnfiles/pcori_trunk/pcori_reports/rcr_pmp1_wp001_nsd2_v01/drnoc/;       
/*SAS Output Files*/              libname DRNOC "&DRNOC.";

/*********** FOLDER CONTAINING FINAL DATASETS TO BE KEPT LOCAL AT THE PARTNER SITE (DMLocal)**********/;
/*CSV Output Files*/              %LET DMLocal=/schaeffer-a/sch-projects/dua-data-projects/PSCANNER/svnfiles/pcori_trunk/pcori_reports/rcr_pmp1_wp001_nsd2_v01/dmlocal/;       
/*SAS Output Files*/              libname DMLocal "&DMLocal.";


/*---------------------------------------------------------------------------------------------------*/
/*                                       End of User Inputs                                          */
/*---------------------------------------------------------------------------------------------------*/

/*****************************************************************************************************/
/**************************** PLEASE DO NOT EDIT CODE BELOW THIS LINE ********************************/
/*****************************************************************************************************/

*Modular program;
%include "&sasmacr.pcornet_mp1.sas" / source2;
%include "&sasmacr.pc_tablecount.sas" / source2;
%include "&sasmacr.pc_report.sas" / source2;

*Modular program calls;
/*Program execution run 1*/
%MODULARPROGRAM1(REQUESTID=rcrwp001,
				 RUNID=r1,
                 ENROLGAP=45,
				 COVERAGE=MD,
                 QUERYFROM=01/01/2015,
                 QUERYTO=12/31/2017,
                 QUERYFILE=cancer001_queryfile.sas7bdat,
                 INCQUERYFILE=,
                 CONDFILE=cancer001_condfile.sas7bdat,
                 OUTTABLESFILE=,
                 AGESTRAT=21-44 45-64 65-84 85+,
				 SEX='M' 'F',
				 HISPANIC='Y' 'N',
				 RACE='01' '02' '03' '04' '05',
				 ENROPTION=EB1,
				 AGECALC=I,
				 THRESHOLD=&THRESHOLD.,
				 EB2DAYS=,
				 EB2ENCNUMS=,
				 EB2ENCLIST=,
 				 RequestName=%quote(RCR cancer query),
				 QueryName=%quote(rcr_pmp1_wp001),
				 KeepDMLocal=Y,
				 DENSTRAT='S' 'R' 'H'   /*option are: 'S' 'R' 'H' 'SR' 'SH' 'HR'*/
);

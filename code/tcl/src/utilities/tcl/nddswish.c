/* nddsWish.c

   Kurt Schwehr - August 1996

   This is the main initialization for a Tcl/Tk wish that knows how to 
   talk to NDDS.  This file uses code automatically generated by the
   nddstcl program that parses XDR data structure specification files.

   Used Alex Derbes serialWish as the starting point for this file.

   This code will probably take a lot from Dan Christian's nddswish,
   which can be found in $ROVERHOME/usr/src/tcl/nddsInit.c

   Shared memory code removed.  It was only used to interface with VEVI.

   - Merged into nddswish.c (Dan Christian's code) Aug 20, 1996
*/

#include <stdio.h>
#include <stdlib.h>			/* for malloc */
#include <tcl.h>
#include <tk.h>

extern int ReadPPMCmd  (ClientData c, Tcl_Interp *i, int ac, char **av);
extern int WritePPMCmd (ClientData c, Tcl_Interp *i, int ac, char **av);
extern int ReadPGMCmd  (ClientData c, Tcl_Interp *i, int ac, char **av);
extern int WritePGMCmd (ClientData c, Tcl_Interp *i, int ac, char **av);

extern int GetTclDate (ClientData c, Tcl_Interp *i, int ac, char **av);

int NddsWishInit (Tcl_Interp *interp);
#ifdef INCLUDE_IMAGE_TCL
int Imagetcl_Init (Tcl_Interp *interp);
#endif

int OurTkInit (Tcl_Interp *interp)
{
    char *rc_file;

					/* these 3 setup calls are mandatory */
    if (Tcl_Init(interp) == TCL_ERROR) {
	printf ("Tcl_Init failed!\n");
        return TCL_ERROR;
    }
    if (Tk_Init(interp) == TCL_ERROR) {
	printf ("Tk_Init failed!\n");
        return TCL_ERROR;
    }
    Tcl_StaticPackage(interp, "Tk", Tk_Init, (Tcl_PackageInitProc *) NULL);

    if (NddsWishInit(interp) == TCL_ERROR) { /* NDDS extension */
	printf ("ndds_Init failed!\n");
	return TCL_ERROR;
    }

#ifdef INCLUDE_IMAGE_TCL
    if (Imagetcl_Init(interp) == TCL_ERROR) { /* image-tcl extension */
	printf ("Imagetcl_Init failed!\n");
	return TCL_ERROR;
    }
#endif

/* Add our read - write routines (which give access to the comments */
    Tcl_CreateCommand(interp, "readppm", ReadPPMCmd, (ClientData) NULL,
		      (void (*)()) NULL);
    Tcl_CreateCommand(interp, "writeppm", WritePPMCmd, (ClientData) NULL,
		      (void (*)()) NULL);
    Tcl_CreateCommand(interp, "readpgm", ReadPGMCmd, (ClientData) NULL,
		      (void (*)()) NULL);
    Tcl_CreateCommand(interp, "writepgm", WritePGMCmd, (ClientData) NULL,
		      (void (*)()) NULL);

    Tcl_CreateCommand(interp, "getdatestring", GetTclDate, (ClientData) NULL,
		      (void (*)()) NULL);

    /*
     * Specify a user-specific startup file to invoke if the application
     * is run interactively.  Typically the startup file is "~/.apprc"
     * where "app" is the name of the application.  If this line is deleted
     * then no user-specific startup file will be run under any conditions.
     */

    rc_file = Tcl_SetVar(interp, "tcl_rcFileName", "~/.nddswishrc", TCL_GLOBAL_ONLY);

    if (NULL == rc_file) {
	printf ("Error: init setting rc_file variable\n");
	return TCL_ERROR;
    }

    return (TCL_OK);
}

#ifdef SunOS
#define NASTY_SUNOS_4_1_3_HACK
#endif

#ifdef NASTY_SUNOS_4_1_3_HACK
#include <math.h>       /* ld.so complains about no acos on SunOS 4.1.3 ??? */
#endif

int
main (int argc, char **argv)
{

/* "UGH" -Kurt */
#ifdef NASTY_SUNOS_4_1_3_HACK
    float blah;
    /* Math lib linking problems because of ??? */
    blah = acos (0.3);          /* FIX: Get rid of this when fix sun crap */
    blah = asin (0.3);          /* FIX: Get rid of this when fix sun crap */
    blah = cosh (1.3);
    blah = sinh (1.3);
    blah = hypot (1.3);
    blah = log (1.3);
    blah = log10 (1.3);
    blah = pow(2,4);
    blah = tanh (1.3);
#endif

    Tk_Main (argc, argv, OurTkInit);	/* never returns */
    return (0);				/* keep compiler happy */
}

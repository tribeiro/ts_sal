/*
 * Please so not edit this file by hand!
 * This file was automatically generated by: nddsgen
 */

#include <rpc/types.h>
#include <rpc/xdr.h>
#include "sciMosaic.h"


bool_t
xdr_sciMosaicStruct(XDR *xdrs, sciMosaicStruct *objp)
{
	if (!xdr_int(xdrs, &objp->camera)) {
		return (FALSE);
	}
	if (!xdr_int(xdrs, &objp->resolution)) {
		return (FALSE);
	}
	if (!xdr_int(xdrs, &objp->x)) {
		return (FALSE);
	}
	if (!xdr_int(xdrs, &objp->y)) {
		return (FALSE);
	}
	if (!xdr_int(xdrs, &objp->width)) {
		return (FALSE);
	}
	if (!xdr_int(xdrs, &objp->height)) {
		return (FALSE);
	}
	if (!xdr_float(xdrs, &objp->panStart)) {
		return (FALSE);
	}
	if (!xdr_float(xdrs, &objp->tiltStart)) {
		return (FALSE);
	}
	if (!xdr_float(xdrs, &objp->panEnd)) {
		return (FALSE);
	}
	if (!xdr_float(xdrs, &objp->tiltEnd)) {
		return (FALSE);
	}
	if (!xdr_float(xdrs, &objp->panStep)) {
		return (FALSE);
	}
	if (!xdr_float(xdrs, &objp->tiltStep)) {
		return (FALSE);
	}
	return (TRUE);
}



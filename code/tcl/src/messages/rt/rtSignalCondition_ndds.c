/*
 * Please so not edit this file by hand!
 * This file was automatically generated by: nddsgen
 */

#include <rpc/types.h>
#include <rpc/xdr.h>
#include "rtSignalCondition.h"


bool_t
xdr_rtSignalConditionStruct(XDR *xdrs, rtSignalConditionStruct *objp)
{
	if (!xdr_int(xdrs, &objp->condition)) {
		return (FALSE);
	}
	return (TRUE);
}



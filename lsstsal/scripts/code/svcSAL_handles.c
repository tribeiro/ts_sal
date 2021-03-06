
#include <sys/shm.h>
#include <sys/time.h>
#include "svcSAL.h"
#include "svcSAL_caches.h"

int svcSAL_DEBUG=1;
int svcSAL_used_handles=0;
svcSAL_cachehandle svcSAL_handle[SAL__MAX_HANDLES];


int svcSAL_initialize () {

  int i;

  for (i=0;i<SAL__MAX_HANDLES;i++) {
     svcSAL_handle[i].shmid=-1;
     svcSAL_handle[i].dataid=-1;
     svcSAL_handle[i].shmsize=0;
     svcSAL_handle[i].ref=NULL;
     strcpy(svcSAL_handle[i].streamname, "NOT IN USE");
  }
  
  return SAL__OK;
}


int svcSAL_connect ( char *name ) {
  int i;
  int datasize;
  int dataid;

   dataid = svcSAL_shmProperties( name, "id");
   if ( dataid == 0 ) {
      return(SAL__NOT_DEFINED);
   }
   datasize = svcSAL_shmProperties( name, "size");



   i=0;
   while (i < SAL__MAX_HANDLES && (i <= svcSAL_used_handles )) {
      i++;
      if ( svcSAL_handle[i].dataid == dataid ) {
          return i;
      }
      if ( svcSAL_handle[i].dataid == -1 ) {
          svcSAL_used_handles = i-1;
      }
   }
   
   if (i == SAL__MAX_HANDLES) {
      return SAL__TOO_MANY_HANDLES;
   }
   if (svcSAL_DEBUG > 0) {
      printf("%s %d id=%x size=%d\n",name,i,dataid,datasize);
   }

   svcSAL_handle[i].shmid = shmget(dataid, datasize , IPC_CREAT|0666);
   svcSAL_handle[i].shmsize = datasize;
   svcSAL_handle[i].dataid = dataid;
   svcSAL_handle[i].ref  = shmat(svcSAL_handle[i].shmid, NULL, 0);
   strcpy( svcSAL_handle[i].streamname , name);
   svcSAL_used_handles = i;

   return i;
}


int svcSAL_connect1 ( char *name , svcSAL_cachehandle *svcSAL_handle1) {
  int datasize;
  int dataid;

   dataid = svcSAL_shmProperties( name, "id");
   if ( dataid == 0 ) {
      return(SAL__NOT_DEFINED);
   }
   datasize = svcSAL_shmProperties( name, "size");

   printf("Connect 1 %s id=%x size=%d",name,dataid,datasize);

   svcSAL_handle1->shmid = shmget(dataid, datasize , IPC_CREAT|0666);
   svcSAL_handle1->shmsize = datasize;
   svcSAL_handle1->dataid = dataid;
   svcSAL_handle1->ref  = shmat(svcSAL_handle1->shmid, NULL, 0);
   strcpy( svcSAL_handle1->streamname , name);

   return(SAL__OK);
}



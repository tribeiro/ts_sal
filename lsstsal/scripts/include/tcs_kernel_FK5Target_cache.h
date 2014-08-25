typedef struct tcs_kernel_FK5Target_cache {
  int cppDummy;
  int syncI;
  char private_revCode[32];
  long private_sndStamp;
  long private_rcvStamp;
  long private_seqNum;
  long private_origin;
  float ra;
  float dec;
  float equinox;
  float epoc;
  float pmRA;
  float pmDec;
  float parallax;
  float rv;
  int syncO;
} tcs_kernel_FK5Target_cache;

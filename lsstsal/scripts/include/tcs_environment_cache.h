typedef struct tcs_environment_cache {
  int cppDummy;
  int syncI;
  int syncO;
  char private_revCode[32];
  long private_sndStamp;
  long private_rcvStamp;
  long private_seqNum;
  long private_origin;
  double teletemps[16];
  double dometemps[16];
  double mirrtemps[16];
  double setpoints[4];
} tcs_environment_cache;

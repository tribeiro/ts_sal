DROP TABLE IF EXISTS camera_WDS_wfsRaft_items;
CREATE TABLE camera_WDS_wfsRaft_items (
  num	int,
  item	char(32),
  type  char(32),
  size  int,
  units char(32),
  freq  float,
  range char(32),
  comment char(128),
  PRIMARY KEY (num)
);
INSERT INTO camera_WDS_wfsRaft_items VALUES (1,"parameters","float",32,"none",0.1,"","");
INSERT INTO camera_WDS_wfsRaft_items VALUES (2,"metrics","float",32,"none",0.1,"","");
INSERT INTO camera_WDS_wfsRaft_items VALUES (3,"zernikes","float",16,"none",0.1,"","");
INSERT INTO camera_WDS_wfsRaft_items VALUES (4,"status"," unsignedlong",1,"none",0.1,"","");
INSERT INTO camera_WDS_wfsRaft_items VALUES (5,"avgInsideImage","string",128,"none",0.1,"","");
INSERT INTO camera_WDS_wfsRaft_items VALUES (6,"avgOutsideImage","string",128,"none",0.1,"","");
INSERT INTO camera_WDS_wfsRaft_items VALUES (7,"CalcImage1","string",128,"none",0.1,"","");
INSERT INTO camera_WDS_wfsRaft_items VALUES (8,"CalcImage2","string",128,"none",0.1,"","");

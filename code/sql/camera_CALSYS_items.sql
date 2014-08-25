DROP TABLE IF EXISTS camera_CALSYS_items;
CREATE TABLE camera_CALSYS_items (
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
INSERT INTO camera_CALSYS_items VALUES (1,"profile","float",1024,"none",0.1,"","");

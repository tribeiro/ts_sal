DROP TABLE IF EXISTS m2_Hexapod_items;
CREATE TABLE m2_Hexapod_items (
  num	int,
  item	char(32),
  type  char(32),
  size  int,
  units char(32),
  freq  float,
  range char(32),
  location char(32),
  comment char(128),
  PRIMARY KEY (num)
);
INSERT INTO m2_Hexapod_items VALUES (1,"Raw","long",31,"",0.054,"","","");
INSERT INTO m2_Hexapod_items VALUES (2,"Calibrated","float",31,"",0.054,"","","");
INSERT INTO m2_Hexapod_items VALUES (3,"Status","octet",31,"",0.054,"","","");

DROP TABLE IF EXISTS camera_Prot_items;
CREATE TABLE camera_Prot_items (
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
INSERT INTO camera_Prot_items VALUES (1,"Status","long",2,"Volts",0.010,"none","Control room","xxx");

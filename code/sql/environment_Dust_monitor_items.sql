DROP TABLE IF EXISTS environment_Dust_monitor_items;
CREATE TABLE environment_Dust_monitor_items (
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
INSERT INTO environment_Dust_monitor_items VALUES (1,"Raw","long",16,"",0.054,"","","");
INSERT INTO environment_Dust_monitor_items VALUES (2,"Calibrated","float",32,"",0.054,"","","");

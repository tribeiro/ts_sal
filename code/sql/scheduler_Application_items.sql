DROP TABLE IF EXISTS scheduler_Application_items;
CREATE TABLE scheduler_Application_items (
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
INSERT INTO scheduler_Application_items VALUES (1,"Status","string",50,"",0.054,"","","");
INSERT INTO scheduler_Application_items VALUES (2,"data","float",200,"",0.054,"","","");

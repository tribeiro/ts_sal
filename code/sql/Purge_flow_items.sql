DROP TABLE IF EXISTS Purge_flow_items;
CREATE TABLE Purge_flow_items (
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
INSERT INTO Purge_flow_items VALUES (2,"Flow_meter","float",1,"lps",0.054,"","");
INSERT INTO Purge_flow_items VALUES (2,"Flow_meter","float",1,"lps",0.054,"","");

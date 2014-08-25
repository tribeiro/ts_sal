DROP TABLE IF EXISTS GAS_voltage_items;
CREATE TABLE GAS_voltage_items (
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
INSERT INTO GAS_voltage_items VALUES (1,"Board_voltage","float",4,"Volt",0.054,"","");
INSERT INTO GAS_voltage_items VALUES (2,"REB_ID"," unsignedshort",1,"",0.054,"","");

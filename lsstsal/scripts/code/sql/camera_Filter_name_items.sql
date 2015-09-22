DROP TABLE IF EXISTS camera_Filter_name_items;
CREATE TABLE camera_Filter_name_items (
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
INSERT INTO camera_Filter_name_items VALUES (1,"Filter_online","string",32,"none",0.054,"none","Camera body","FCS: Name of filter at online position");
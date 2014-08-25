DROP TABLE IF EXISTS skycam_command_items;
CREATE TABLE skycam_command_items (
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
INSERT INTO skycam_command_items VALUES (1,"cmdID","long",1,"",0.054,"","","");
INSERT INTO skycam_command_items VALUES (2,"device","string",16,"",0.054,"","","");
INSERT INTO skycam_command_items VALUES (3,"operation","string",16,"",0.054,"","","");
INSERT INTO skycam_command_items VALUES (4,"value","string",16,"",0.054,"","","");
INSERT INTO skycam_command_items VALUES (5,"modifiers","string",128,"",0.054,"","","");

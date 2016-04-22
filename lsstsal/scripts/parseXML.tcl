#!/usr/bin/tclsh

proc parseXMLtoidl { fname } { 
global IDLRESERVED SAL_WORK_DIR SAL_DIR CMDS CMD_ALIASES EVTS EVENT_ALIASES
   set fin [open $fname r]
   set fout ""
   set ctype ""
   set subsys ""
   while { [gets $fin rec] > -1 } {
      set tag   [lindex [split $rec "<>"] 1]
      set value [lindex [split $rec "<>"] 2]
      if { $tag == "SALTelemetry" }    {set ctype "telemetry"}
      if { $tag == "SALCommand" }      {
          set ctype "command"
          set device ""; set property ""; set action "" ; set vvalue ""
      }
      if { $tag == "SALEvent" }        {set ctype "event"}
      if { $tag == "SALTelemetrySet" } {set ctype "telemetry"}
      if { $tag == "SALCommandSet" }   {set ctype "command"}
      if { $tag == "SALEventSet" }     {set ctype "event"}
      if { $tag == "Alias" }           {
          set alias $value
          if { $ctype == "command" } {set CMDS($subsys,$alias) $alias}
          if { $ctype == "event" }   {set EVTS($subsys,$alias) $alias}
      }
      if { $tag == "Device" }          {set device $value}
      if { $tag == "Property" }        {set property $value}
      if { $tag == "Action" }          {set action $value}
      if { $tag == "Value" }           {set vvalue $value}
      if { $tag == "Subsystem" }       {set subsys $value}
      if { $tag == "/SALEvent" } {
         set EVTS($subsys,$alias) $alias
         set EVENT_ALIASES($subsys) [lappend EVENT_ALIASES($subsys) $alias]
      }
      if { $tag == "/SALCommand" } {
         set CMDS($subsys,$alias) "$device $property $action $value"
         set CMD_ALIASES($subsys) [lappend CMD_ALIASES($subsys) $alias]
      }
      if { $tag == "EFDB_Topic" } {
         if { $fout != "" } {
           puts $fout "\};"
           puts $fout "#pragma keylist $tname"
           close $fout
           if { $ctype == "telemetry" } {
             close $fsql
           }
           if { $itemid == 0 } {
              exec rm $SAL_WORK_DIR/idl-templates/[set tname].idl
           }
        }
        set itemid 0
        set tname $value
        puts stdout "Translating $tname"
        set fout [open $SAL_WORK_DIR/idl-templates/[set tname].idl w]
        puts $fout "struct $tname \{"
        add_private_idl $fout
        if { $ctype == "command" } {
           puts $fout "   string<32>	device;
   string<32>	property;
   string<32>	action;
   string<32>	value;"
        }
        if { $ctype == "telemetry" } {
           gentopicdefsql $tname
           set fsql [open $SAL_DIR/code/sql/[set tname]_items.sql a]
        }
      }
      if { $tag == "EFDB_Name"} {
        set item $value ; set unit ""
        incr itemid 1
        set desc "" ; set range "" ; set location ""
        set freq 0.054 ; set sdim 1
        if { [lsearch $IDLRESERVED [string tolower $item]] > -1 } {
           puts stdout "Invalid use of IDL reserved token $id"
           exit 1
        }
      }
      if { $tag == "IDL_Type"}        {set type $value}
      if { $tag == "IDL_Size"}        {set sdim $value}
      if { $tag == "Description"}     {set desc $value}
      if { $tag == "Frequency"}       {set freq $value}
      if { $tag == "Range"}           {set range $value}
      if { $tag == "Sensor_location"} {set location $value}
      if { $tag == "Count"}           {set idim $value}
      if { $tag == "Units"}           {set unit $value}
      if { $tag == "/item" } {
         if { $type == "string" } {
            if { $sdim > 1 } {
               set declare "   string<[set sdim]> $item;"
            } else {
               set declare "   string $item;"
            }
         } else {
            if { $idim > 1 } {
               set declare "   $type $item\[[set idim]\];"
            } else {
               set declare "   $type $item;"
            }
         }
         set declare [string trim $declare " ;"]
         puts $fout $declare
         set ydec [join [split $declare "\[" ] "("]
         set declare [join [split $ydec "\]" ] ")"]
         if { $ctype == "command" } {
            lappend CMDS($subsys,$alias,param) "$declare"
            lappend CMDS($subsys,$alias,plist) [lindex $declare 1]
         }
         if { $ctype == "event" } {
            lappend EVTS($subsys,$alias,param) "$declare"
            lappend EVTS($subsys,$alias,plist) [lindex $declare 1]
         }
         if { $ctype == "telemetry" } {
           puts $fsql "INSERT INTO [set tname]_items VALUES ($itemid,\"$item\",\"$type\",$idim,\"$unit\",$freq,\"$range\",\"$location\",\"$desc\");"
         }
      }
   }
   if { $fout != "" } {
      puts $fout "\};"
      puts $fout "#pragma keylist $tname"
      close $fout
      if { $ctype == "telemetry" } {
        close $fsql
      }
   }
   close $fin
   puts stdout "itemid for $SAL_WORK_DIR/idl-templates/[set tname].idl=  $itemid"
   if { $itemid == 0 } {
      exec rm $SAL_WORK_DIR/idl-templates/[set tname].idl
   }
   if { [info exists CMD_ALIASES($subsys)] } {
    if { $CMD_ALIASES($subsys) != "" } {
     puts stdout "Generating test command gui input"        
     set fout [open $SAL_WORK_DIR/idl-templates/validated/[set subsys]_cmddef.tcl w]
     puts $fout "set CMD_ALIASES($subsys) \"$CMD_ALIASES($subsys)\""
     foreach c [array names CMDS] {
        puts $fout "set CMDS($c) \"$CMDS($c)\""
     }
     close $fout
    }
   }
   if { [info exists EVENT_ALIASES($subsys)] } {
    if { $EVENT_ALIASES($subsys) != "" } {
     puts stdout "Generating test event gui input"        
     set fout [open $SAL_WORK_DIR/idl-templates/validated/[set subsys]_evtdef.tcl w]
     puts $fout "set EVENT_ALIASES($subsys) \"$EVENT_ALIASES($subsys)\""
     foreach c [array names EVTS] {
        puts $fout "set EVTS($c) \"$EVTS($c)\""
     }
     close $fout
    }
   }
}


set IDLRESERVED "abstract any attribute boolean case char component const consumes context custom default double emits enum eventtype exception factory false finder fixed float getraises home import in inout interface local long module multiple native object octet oneway out primarykey private provides public publishes raises readonly sequence setraises short string struct supports switch true truncatable typedef typeid typeprefix union unsigned uses valuebase valuetype void wchar wstring"
set SAL_DIR $env(SAL_DIR)
set SAL_WORK_DIR $env(SAL_WORK_DIR)
source $SAL_DIR/add_private_idl.tcl
source $SAL_DIR/checkidl.tcl



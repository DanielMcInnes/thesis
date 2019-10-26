with Ada.Finalization;
with Ada.Strings; 
with Ada.Strings.Bounded;
with Ada.Text_IO;

package NonSparkTypes is
   package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 500);
   package messageid_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package action_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package BootReasonEnumType is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 16);         
   --ApplicationReset - The Charging Station rebooted due to an application error.
   --FirmwareUpdate - The Charging Station rebooted due to a firmware update.
   --LocalReset - The Charging Station rebooted due to a local reset command.
   --PowerUp - The Charging Station powered up and registers itself with the CSMS.
   --RemoteReset - The Charging Station rebooted due to a remote reset command.
   --ScheduledReset -The Charging Station rebooted due to a scheduled reset command.
   --Triggered - Requested by the CSMS via a TriggerMessage
   --Unknown - The boot reason is unknown.
   --Watchdog -The Charging Station rebooted due to an elapsed watchdog timer.

   package ChargingStationType is
      ------------------------------------------------------------------------------------------------------------      
      -- Field Name      Field Type    Card. Description
      ------------------------------------------------------------------------------------------------------------      
      -- serialNumber    string[0..20] 0..1  Optional. Vendor-specific device identifier.
      -- model           string[0..20] 1..1  Required. Defines the model of the device.
      -- vendorName      string[0..50] 1..1  Required. Identifies the vendor (not necessarily in a unique manner).
      -- firmwareVersion string[0..50] 0..1  Optional. This contains the firmware version of the Charging Station.
      -- modem           ModemType     0..1  Optional. Defines the functional parameters of a communication link.
      
      package serialNumber is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
      package model is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
      package vendorName is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
      package firmwareVersion is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   end ChargingStationType;
   
   package bootnotification_t is      
      package response is
         package currentTime is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package interval is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package status is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
      end response;
   end bootnotification_t;
   
   package ModemType is
      package iccid_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
      package imsi_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   end ModemType;
   
   procedure put(msg : string);
   procedure put_line(msg : string);


   

end NonSparkTypes;

with Ada.Finalization;
with Ada.Strings; 
with Ada.Strings.Bounded;
with Ada.Text_IO;

package ocpp is
   
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

   package ModemType is
      package iccid is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
      package imsi is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   end ModemType;
   
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
   
   
      
   
   currentTime: ocpp.BootReasonEnumType.Bounded_String := ocpp.BootReasonEnumType.To_Bounded_String(""); --eg. PowerUp
   interval:  ocpp.BootNotification_t.response.interval.Bounded_String := ocpp.BootNotification_t.response.interval.To_Bounded_String(""); -- eg. SingleSocketCharger
   status: ocpp.ChargingStationType.vendorName.Bounded_String := ocpp.ChargingStationType.vendorName.To_Bounded_String(""); -- eg. VendorX
   

   type call is tagged record
      messagetypeid : integer;-- eg. 2
      messageid : messageid_t.Bounded_String; -- eg. 19223201
      action : action_t.Bounded_String;-- eg. BootNotification
   end record;
   
   type callresult is tagged record
      messagetypeid : integer;-- eg. 3
      messageid : messageid_t.Bounded_String; -- eg. 19223201
   end record;
   
   type ChargingStation_t is tagged record
      serialNumber : ocpp.ChargingStationType.serialNumber.Bounded_String := ocpp.ChargingStationType.serialNumber.To_Bounded_String("");
      model:  ocpp.ChargingStationType.model.Bounded_String := ocpp.ChargingStationType.model.To_Bounded_String(""); -- eg. SingleSocketCharger
      vendorName: ocpp.ChargingStationType.vendorName.Bounded_String := ocpp.ChargingStationType.vendorName.To_Bounded_String(""); -- eg. VendorX
      firmwareVersion: ocpp.ChargingStationType.firmwareVersion.Bounded_String := ocpp.ChargingStationType.firmwareVersion.To_Bounded_String("");
   end record;
   
   procedure Initialize(Self : out ChargingStation_t);
   

   procedure single_char_to_int(intstring : in ocpp.packet.Bounded_String; 
                                retval : out Integer)
     with Pre     => ocpp.packet.Length(intstring) = 1;

   procedure move_index_past_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      Last   : out Natural)
     with
       Post => (Last <= ocpp.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then (index <= ocpp.packet.Length(msg))),
     Global => null;

   procedure move_index_past_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      First  : out Positive;
      Last   : out Natural)
     with
       Post => (Last <= ocpp.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then First <= ocpp.packet.Length(msg)) and
     (index <= ocpp.packet.Length(msg)),
     Global => null;

   procedure put(msg : string);
   procedure put_line(msg : string);

   procedure find_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in Positive;
      First  : out Positive;
      Last   : out Natural)
     with
       Pre    => (if ocpp.packet.Length(msg) /= 0 then index <= ocpp.packet.Length(msg)),
       Post => (Last <= ocpp.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then First <= ocpp.packet.Length(msg)),
     Global => null;
   
   generic
      type string_t (<>) is limited private;
      with function length (msg : string_t) return integer;
      with function element(msg : string_t; index: Positive) return character;
      with function to_string(msg : string_t) return string;        
   procedure findnonwhitespace(msg: in string_t;
                               index: in out Positive;
                               retval: out boolean);
   
   generic
      Max: Positive;
      type string_t (<>) is private;
      with function to_string(msg : string_t) return string;      
      with function To_Bounded_String(msg : string;
                                      Drop : Ada.Strings.Truncation := Ada.Strings.Error) return string_t;
      with function length (msg : string_t) return integer;
      
   procedure findquotedstring(msg: in ocpp.packet.Bounded_String;
                              index : in out Positive;
                              found : out Boolean;
                              foundString: in out string_t) 
     with  Global => null;
end ocpp;

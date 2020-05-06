with ada.Containers.Vectors;
with Ada.Finalization;
with Ada.Strings; 
with Ada.Strings.Bounded;
with Ada.Text_IO;

package NonSparkTypes is
   package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 5000);
   package messageid_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package action_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package BootReasonEnumType is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 16);
   
   package GetVariableResultType is
      package strattributeValue_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 2500);
   end GetVariableResultType;

   package SetVariableDataType is
      package strattributeValue_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 2500);
   end SetVariableDataType;

   package StatusNotificationRequest is
      package strtimestamp_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   end StatusNotificationRequest;
   
   package VariableType is
      package strname_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
      package strinstance_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   end VariableType;
      
   package ComponentType is
      package strname_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50); -- TODO string;
      package strinstance_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50); -- TODO string;
   end ComponentType;
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

   use ChargingStationType.serialNumber;
   subtype index_t is Natural range 1 .. 100;
   
   package vector_chargers is new Ada.Containers.Vectors
     (Index_Type => index_t, 
      Element_Type => NonSparkTypes.ChargingStationType.serialNumber.Bounded_String);   
   subtype vecChargers_t is vector_chargers.Vector;
      
   package bootnotification_t is      
      package response is
         package currentTime is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package interval is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package status is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
      end response;
   end bootnotification_t;
   
   --package attributeValue_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 1000); -- used by setVariables, getVariables
   package attributeValue_t is 
      package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 1000);
      procedure FromString(attribute : in string;
                           str : out string_t.Bounded_String);
   end attributeValue_t;
   
   package setvariables_t is
      package request is
      end request;
   end setvariables_t;
   
   
   package ModemType is
      package iccid_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
      package imsi_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   end ModemType;
   
   package VariableType_t is
      package name is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50); 
      package instance is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   end VariableType_t;
      
   procedure put(msg : string);
   procedure put_line(msg : string);

   procedure put(msg : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String);
   procedure put_line(msg : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String);

   procedure contains(theList : in out vecChargers_t;
                      theValue: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String;
                      retval: out Boolean);
   
   procedure append(theList : in out vecChargers_t;
                    retval : out Boolean;
                    theValue: in NonSparkTypes.ChargingStationType.serialNumber.Bounded_String
                   );   
   
   function Uncased_Equals (L, R : String) return Boolean;

end NonSparkTypes;

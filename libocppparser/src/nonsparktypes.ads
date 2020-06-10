
with Ada.Finalization;
with Ada.Strings; 
with Ada.Strings.Bounded; 
with Ada.Text_IO;

package NonSparkTypes is
   pragma Annotate(GNATprove, Terminating, NonSparkTypes);
   
   package packet is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 5000);
   package messageid_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   package action_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);

   package MessageContentType is
      package strlanguage_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 8);
      package strcontent_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 512);
   end MessageContentType;
   
   package GroupIdTokenType is
      package stridToken_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   end GroupIdTokenType;
   
   package IdTokenInfoType is
      package strcacheExpiryDateTime_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 360);
      package strlanguage1_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 8);
      package strlanguage2_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 8);
   end IdTokenInfoType;
   
   package AdditionalInfoType is
      package strtype_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
      package stradditionalIdToken_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   end AdditionalInfoType;
   
   package IdTokenType is
      package stridToken_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   end IdTokenType;
   
   package OCSPRequestDataType is
      package strissuerNameHash_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 128);
      package strissuerKeyHash_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 128);
      package strserialNumber_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 40);
      package strresponderURL_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 512);
   end OCSPRequestDataType;
   
   package ChargingStationType is
      package strserialNumber_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 25);
      package strmodel_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
      package strvendorName_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
      package strfirmwareVersion_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   end ChargingStationType;
   
   package ModemType is
      package striccid_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
      package strimsi_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);
   end ModemType;
   
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

   package HeartbeatResponse is
         package strcurrentTime_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   end HeartbeatResponse;
   
   package BootNotificationResponse is      
         package strcurrentTime_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package strinterval_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
         package strstatus_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 36);
   end BootNotificationResponse;
   
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
   
   package VariableType_t is
      package name is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50); 
      package instance is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 50);
   end VariableType_t;
      
   procedure put(msg : string);
   procedure put_line(msg : string);

   procedure put(msg : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String);
   procedure put_line(msg : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String);

   function Uncased_Equals (L, R : String) return Boolean;

end NonSparkTypes;

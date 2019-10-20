pragma SPARK_Mode (On);

with Ada.Finalization;
with Ada.Strings; 
with Ada.Strings.Bounded;
with Ada.Text_IO;
with NonSparkTypes; use NonSparkTypes;

package ocpp is
   
   type call is tagged record
      messagetypeid : integer;-- eg. 2
      messageid : messageid_t.Bounded_String; -- eg. 19223201
      action : action_t.Bounded_String;-- eg. BootNotification
   end record;
   
   type callresult is tagged record
      messagetypeid : integer;-- eg. 3
      messageid : messageid_t.Bounded_String; -- eg. 19223201
   end record;
   
   type ModemType_t is tagged record
      iccid: ModemType.iccid_t.Bounded_String;
      imsi: ModemType.imsi_t.Bounded_String;
   end record;   
   procedure Initialize(Self : out ModemType_t);
   
   type ChargingStation_t is tagged record
      serialNumber : NonSparkTypes.ChargingStationType.serialNumber.Bounded_String := NonSparkTypes.ChargingStationType.serialNumber.To_Bounded_String("");
      model:  NonSparkTypes.ChargingStationType.model.Bounded_String := NonSparkTypes.ChargingStationType.model.To_Bounded_String(""); -- eg. SingleSocketCharger
      vendorName: NonSparkTypes.ChargingStationType.vendorName.Bounded_String := NonSparkTypes.ChargingStationType.vendorName.To_Bounded_String(""); -- eg. VendorX
      firmwareVersion: NonSparkTypes.ChargingStationType.firmwareVersion.Bounded_String := NonSparkTypes.ChargingStationType.firmwareVersion.To_Bounded_String("");
      modem: ModemType_t;
   end record;
   
   procedure Initialize(Self : out ChargingStation_t);
   

   procedure move_index_past_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      Last   : out Natural)
     with
       Post => (Last <= NonSparkTypes.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then (index <= NonSparkTypes.packet.Length(msg))),
     Global => null;

   procedure move_index_past_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      First  : out Positive;
      Last   : out Natural)
     with
       Post => (Last <= NonSparkTypes.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then First <= NonSparkTypes.packet.Length(msg)) and
     (index <= NonSparkTypes.packet.Length(msg)),
     Global => null;

   procedure find_token
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in Positive;
      First  : out Positive;
      Last   : out Natural)
     with
       Pre    => (if NonSparkTypes.packet.Length(msg) /= 0 then index <= NonSparkTypes.packet.Length(msg)),
       Post => (Last <= NonSparkTypes.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then First <= NonSparkTypes.packet.Length(msg)),
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
      
   procedure findquotedstring(msg: in NonSparkTypes.packet.Bounded_String;
                              index : in out Positive;
                              found : out Boolean;
                              foundString: in out string_t) 
     with  Global => null;
end ocpp;

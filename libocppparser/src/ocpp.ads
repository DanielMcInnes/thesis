pragma SPARK_Mode (On);

with Ada.Finalization;
with Ada.Strings; 
with Ada.Strings.Bounded;
with Ada.Text_IO;
with NonSparkTypes; use NonSparkTypes; use NonSparkTypes.action_t;

package ocpp is
   type call is tagged record
      messagetypeid : integer := 2;-- eg. 2
      messageid : messageid_t.Bounded_String; -- eg. 19223201
      action : action_t.Bounded_String;-- eg. BootNotification
   end record;
   procedure checkValid(msg: in NonSparkTypes.packet.Bounded_String;
                        msgindex: in Integer;
                        request: in ocpp.call;
                        expectedAction: in action_t.Bounded_String;
                        valid: out Boolean
                       )
     with
       Global => null,
       Depends => (
                     valid => (msg, msgindex, request, expectedAction)
                  ),
       post => (if valid = true then
                  (request.messagetypeid = 2) and
                  (NonSparkTypes.messageid_t.Length(request.messageid) > 0) and
                    (request.action = expectedAction)
               );

   type callresult is tagged record
      messagetypeid : integer;-- eg. 3
      messageid : messageid_t.Bounded_String; -- eg. 19223201
   end record;
   
   procedure checkValid(msg: in NonSparkTypes.packet.Bounded_String;
                        msgindex: in Integer;
                        request: in ocpp.callresult;
                        valid: out Boolean
                       )
     with
       Global => null,
       Depends => (
                     valid => (msg, msgindex, request)
                  ),
       post => (if valid = true then
                  (request.messagetypeid = 3) and
                  (NonSparkTypes.messageid_t.Length(request.messageid) > 0)
               );

   type ModemType_t is tagged record
      iccid: ModemType.striccid_t.Bounded_String;
      imsi: ModemType.strimsi_t.Bounded_String;
   end record;   
   procedure Initialize(Self : out ModemType_t);
   
   type ChargingStation_t is tagged record
      serialNumber : NonSparkTypes.ChargingStationType.strserialNumber_t.Bounded_String := NonSparkTypes.ChargingStationType.strserialNumber_t.To_Bounded_String("");
      model:  NonSparkTypes.ChargingStationType.strmodel_t.Bounded_String := NonSparkTypes.ChargingStationType.strmodel_t.To_Bounded_String(""); -- eg. SingleSocketCharger
      vendorName: NonSparkTypes.ChargingStationType.strvendorName_t.Bounded_String := NonSparkTypes.ChargingStationType.strvendorName_t.To_Bounded_String(""); -- eg. VendorX
      firmwareVersion: NonSparkTypes.ChargingStationType.strfirmwareVersion_t.Bounded_String := NonSparkTypes.ChargingStationType.strfirmwareVersion_t.To_Bounded_String("");
      modem: ModemType_t;
   end record;
   

   procedure Initialize(Self : out ChargingStation_t);

   procedure findnextinteger(msg: in NonSparkTypes.packet.Bounded_String;
                             index : in out Positive;
                             foundInteger: out integer;
                             found : out Boolean) 
     with  Global => null,
     post => (if found = true then index < Integer'Last);
   
   
   procedure ParseMessageType(msg:   in  NonSparkTypes.packet.Bounded_String;
                              messagetypeid : out integer;-- eg. 2
                              index: in out Integer;
                              valid: out Boolean)
     with  Global => null,
     post => (if valid = true then 
                (messagetypeid = 2 or messagetypeid = 3 or messagetypeid = 4)
              and
                (index < NonSparkTypes.packet.Length(msg))
             );
   
                             

   procedure ParseMessageId(msg:   in  NonSparkTypes.packet.Bounded_String;
                            messageid : out NonSparkTypes.messageid_t.Bounded_String;
                            index: in out Integer;
                            valid: out Boolean
                           );

   procedure ParseAction(msg:   in  NonSparkTypes.packet.Bounded_String;
                         msgindex: in out Integer;
                         action : out NonSparkTypes.action_t.Bounded_String;
                         valid: out Boolean
                        );

   generic
      Max: Positive;
      type string_t (<>) is private;
      with function to_string(msg : string_t) return string;      
      with function To_Bounded_String(msg : string; Drop : Ada.Strings.Truncation := Ada.Strings.Error) return string_t;
      with function length (msg : string_t) return integer;      
   procedure findquotedstring(msg: in NonSparkTypes.packet.Bounded_String;
                              msgindex : in out Integer;
                              found : out Boolean;
                              foundString: out string_t) 
     with  Global => null;
   
   procedure findQuotedKey(msg: in NonSparkTypes.packet.Bounded_String;
                           msgIndex: in out Integer;
                           valid: out Boolean;
                           key: in string);

   procedure findQuotedKeyQuotedValue(msg: in NonSparkTypes.packet.Bounded_String;
                                      msgIndex: in out Integer;
                                      valid: out Boolean;
                                      key: in string;
                                      value: out NonSparkTypes.packet.Bounded_String);
   --        with
   --          Global => null,
   --          post => (if valid = true then
   --                     (msgIndex > 0)
   --                  );

   procedure findQuotedKeyUnquotedValue(msg: in NonSparkTypes.packet.Bounded_String;
                                        msgIndex: in out Integer;
                                        valid: out Boolean;
                                        key: in string;
                                        value: out Integer);

private
   
   procedure moveIndexPastToken
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out integer;
      Last   : out Natural)
     with
       Post => (Last <= NonSparkTypes.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then 
        (index <= NonSparkTypes.packet.Length(msg)) and
          (index > 0)
     ),
     Global => null;

   procedure moveIndexPastToken
     (msg : packet.Bounded_String;
      token    : Character;
      index   : in out Positive;
      First  : out Positive;
      Last   : out Natural)
     with
       Post => (Last <= NonSparkTypes.packet.Length(msg)) and 
       (Last < Integer'Last) and
     (if Last /= 0 then 
        (First <= NonSparkTypes.packet.Length(msg)) and
          (index <= NonSparkTypes.packet.Length(msg))),
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
                               msgindex: in out Positive;
                               retval: out boolean);
   --   with
   --          Global => null,
   --          post => (if retval = true then
   --                     (msgindex > 0) and
   --                         (msgindex <= Length(msg))
   --                  );
   
   procedure findString(msg: in NonSparkTypes.packet.Bounded_String;
                        msgIndex: in out Integer;
                        valid: out Boolean;
                        needle: string);
   --   with
   --          Global => null,
   --          post => (if valid = true then
   --                     (msgindex > 0) and
   --                         (msgindex <= NonSparkTypes.packet.Length(msg))
   --                  );

end ocpp;

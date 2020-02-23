package EVSEType is

   -- EVSEType is used by: Common:ComponentType , TriggerMessageRequest , Renegotiate15118ScheduleRequest ,TransactionEventRequest , ReserveNowRequest.ReservationType

   type Class is tagged record

      id: Integer;           -- Required. EVSE Identifier. When 0, the ID references the Charging Station as a whole.
      connectorId: Integer;  -- Optional. An id to designate a specific connector (on an EVSE) by connector index number.
   end record;


end EVSEType;

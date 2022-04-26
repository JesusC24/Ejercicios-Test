trigger FlightBookingsTrigger on FlightBookings__c (before insert, before update, before delete, 
after insert, after update, after delete, after undelete) {
    TriggerFactory.createHandler(FlightBookings__c.getSObjectType());
}
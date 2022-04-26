trigger PassengerTrigger on Passenger__c (before insert, before update, before delete, 
after insert, after update, after delete, after undelete) {
    TriggerFactory.createHandler(Passenger__c.getSObjectType());
}
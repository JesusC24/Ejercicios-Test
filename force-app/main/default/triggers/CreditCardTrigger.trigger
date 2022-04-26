trigger CreditCardTrigger on CreditCard__c (before insert, before update, before delete, 
after insert, after update, after delete, after undelete) {
    TriggerFactory.createHandler(CreditCard__c.getSObjectType());
}
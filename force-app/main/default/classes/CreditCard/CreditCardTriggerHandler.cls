public with sharing class CreditCardTriggerHandler implements ITrigger {
    //Var declaration
    User usuarioAccenture; //usuario que se pide que no se valore si la creditCard es añadida por ese
    List<Opportunity> listOpportunity = new List<Opportunity>(); //vamos a guardar las nuevas oportunidades
    Map<Id, Contact> listContactAssociados;
    //Constant declaration

    //Builder

    // Handler before methods

    /**
    * This method is called prior to execution of a BEFORE trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
    */
    public void bulkBefore() {

    }

    public void beforeInsert(SObject sObj) {
        
    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {

    }

    public void beforeDelete(SObject sObj) {

    }

    // Handler after methods

    public void bulkAfter() {
        usuarioAccenture = [select Id, Name from User where Name = 'Accenture TEST' limit 1];

        //Cojo los diferentes Id para hacer la consulta para sacar los contactos relacionados con la creditCard
        List<Id> contacts = new List<Id>();

        for(SObject creditCard : Trigger.new) {
            contacts.add(((CreditCard__c) creditCard).Contact__c);
        }

        listContactAssociados = new Map<Id, Contact>([select Id, Name, Premium__c, AccountId from Contact where Id in :contacts]);
    }

    public void afterInsert(SObject sObj) {
        CreditCard__c creditCard = (CreditCard__c) sObj;

        if(creditCard.OwnerId != usuarioAccenture.Id) {
            Contact contact = listContactAssociados.get(creditCard.Contact__c);
            if(contact.Premium__c) {
                Date closeDateBaseCreditCard = Date.parse('01/' + creditCard.ExpirationMonth__c +  '/' + creditCard.ExpirationYear__c);
                Opportunity opportunity = new Opportunity(CloseDate = closeDateBaseCreditCard, StageName = 'Not started',
                                            AccountId = contact.AccountId, Name = contact.Name);

                listOpportunity.add(opportunity);
            }
        }
    }

    public void afterUpdate(SObject oldSobj, SObject sObj) {
        
    }

    public void afterDelete(SObject sObj) {

    }

    /**
    * This method is called once all records have been processed by the trigger.
    * Use this method to accomplish any final operations such as creation or updates of other records.
    */
    public void andFinally() {
        insert listOpportunity;
    }

    // Other methods
}

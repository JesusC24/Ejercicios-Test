public with sharing class ContactTriggerHandler implements ITrigger {

    //Var declaration

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
        Contact contact = (Contact)sObj;
        if(contact.NIF__c !=  null) {
            validarNif((Contact) sObj);
        }
    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {
        Contact contact = (Contact)sObj;
        if(contact.NIF__c !=  null) {
            validarNif((Contact) sObj);
        }
    }

    public void beforeDelete(SObject sObj) {

    }

    // Handler after methods

    public void bulkAfter() {

    }

    public void afterInsert(SObject sObj) {

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

    }

    // Other methods
    private void validarNif(Contact contact) {
        if(!(Check.nif(contact.NIF__c))) {
            contact.addError('Error in the format of the nif');
        }
    }

}

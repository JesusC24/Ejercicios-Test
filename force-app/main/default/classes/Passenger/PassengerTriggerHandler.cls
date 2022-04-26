public class PassengerTriggerHandler implements ITrigger {

    //Var declaration
    Map<Id, Contact> contactWithSameNifThatPassenger;

    //Constant declaration

    //Builder

    // Handler before methods

    /**
    * This method is called prior to execution of a BEFORE trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
    */
    public void bulkBefore() {

        List<String> nifs = new List<String>();

        for(SObject passenger : Trigger.new) {
            nifs.add(((Passenger__c) passenger).IDCard__c);
        }

        contactWithSameNifThatPassenger = new Map<Id, Contact>([select NIF__c, Name, LastName, Id from Contact where NIF__c in :nifs]);

    }

    public void beforeInsert(SObject sObj) {
        Passenger__c passenger = (Passenger__c) sObj;
        if(passenger.IDCard__c != null) {
            validarNif(passenger);
            asociarContact(passenger);
        }

        if(passenger.Contact__c == null) {
            asociarContact(passenger);
        }
    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {
        Passenger__c passenger = (Passenger__c) sObj;
        if(passenger.IDCard__c != null) {
            validarNif(passenger);
        }

        if(passenger.Contact__c == null) {
            asociarContact(passenger);
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
    private void validarNif(Passenger__c passenger) {
        if(!(Check.nif(passenger.IDCard__c))) {
            passenger.addError('Error in the format of the nif');
        }
    }

    private void asociarContact(Passenger__c passenger) {
        for(Contact contact : contactWithSameNifThatPassenger.values()) {
            if(passenger.IDCard__c == contact.NIF__c) {
                 passenger.Contact__c = contact.Id;
                 break;
            }
        }
    }
}

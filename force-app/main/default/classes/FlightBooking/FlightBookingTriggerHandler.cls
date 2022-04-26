/**
 * Controlado de la clase para manejar las posibles entradas del Trigger
 */
public class FlightBookingTriggerHandler implements ITrigger {

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
        
    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {
        FlightBookings__c newFlight = (FlightBookings__c) sObj;
        FlightBookings__c oldFlight = (FlightBookings__c) oldSobj;

        //Marca la casilla comparar si el campo 'Origen' o 'Destino' han sido cambiados
        if((newFlight.Origin__c != oldFlight.Origin__c) || (newFlight.Destination__c != oldFlight.Destination__c)) {
            newFlight.Modified__c = true;
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

}


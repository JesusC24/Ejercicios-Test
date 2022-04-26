@isTest
public with sharing class TestPassengerIntegration {
    @isTest static void checkNif() {
        List<Passenger__c> passengers = TestPassengerFactory.createPassenger(1, false);
        List<Passenger__c> passengersError = TestPassengerFactory.createPassenger(1, true);

        Test.startTest();
        Database.SaveResult resultCorrect = Database.insert(passengers.get(0));
        
        try {
            insert passengersError.get(0);
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Error in the format of the nif'), 'The passenger has a wrong NIF');
        }

        passengers.get(0).IDCard__c = '12345678A';

        try {
            upsert passengers.get(0);
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Error in the format of the nif'), 'The passenger has a wrong NIF');
        }
 
        Test.stopTest();
        
        System.assert(resultCorrect.isSuccess(), 'The passenger was save successfully');
    }

    @isTest static void addContactAssociated() {
        String nifExample = '12345678Z';
        Passenger__c passenger = TestPassengerFactory.createPassengerWithNifInContact(nifExample);

        Test.startTest();
        Database.SaveResult result = Database.insert(passenger);
        Test.stopTest();

        Passenger__c newPassenger = [select Id, Contact__r.NIF__c from Passenger__c where Id = :result.id];
        System.assertEquals(newPassenger.Contact__r.NIF__c, nifExample, 'The passenger have the good contact');
    }
}



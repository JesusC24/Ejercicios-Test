@isTest
public with sharing class TestContactIntegration {
    @isTest static void checkNif() {
        List<Contact> contactsCorrect = TestContactFactory.createContact(1, false);
        List<Contact> contactsError = TestContactFactory.createContact(1, true);

        Test.startTest();
        Database.SaveResult resultCorrect = Database.insert(contactsCorrect.get(0));
        
        try {
            insert contactsError.get(0);
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Error in the format of the nif'), 'The contact has a wrong NIF');
        }

        contactsCorrect.get(0).NIF__c = '44572191P';
        Database.SaveResult resultCorrectUpdate = Database.update(contactsCorrect.get(0));
 
        Test.stopTest();
        
        System.assert(resultCorrect.isSuccess(), 'The contact was save successfully');
        System.assert(resultCorrectUpdate.isSuccess(), 'The contact was save successfully');
    }

}

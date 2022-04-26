@isTest
public with sharing class TestContactFactory {
    public static List<Contact> createContact(Integer veces, Boolean errorNif) {
        List<Contact> contacts = new List<Contact>();

        for(Integer i=0; i<veces; i++) {
            Contact contact = new Contact(LastName = 'Test ' + i);

            if(errorNif) {
                contact.NIF__c = '12345678A'; //nif error
            } else {
                contact.NIF__c = '12345678Z'; //nif bueno
            }
            
            contacts.add(contact);
        }

        return contacts;
    }
}

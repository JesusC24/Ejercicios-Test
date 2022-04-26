@isTest
public with sharing class TestCreditCardFactory {
    public static CreditCard__c createCreditCard(Boolean contactPremium) {
        Contact contact = new Contact(LastName = 'Test Contact', Premium__c = contactPremium);
        CreditCard__c creditCard = new CreditCard__c(Name = 'Test Credit Card', ExpirationMonth__c = 12, ExpirationYear__c = 2024);

        insert contact;
        return creditCard;
    }
}

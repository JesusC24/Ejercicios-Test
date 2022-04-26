@isTest
public with sharing class TestCreditCardIntegration {
    @IsTest static void createOpportunity() {
        CreditCard__c creditCard = TestCreditCardFactory.createCreditCard(true);
        creditCard.Contact__c = [select Id from Contact where Name = 'Test Contact' limit 1].Id;

        Test.startTest();
        insert creditCard;
        Test.stopTest();

        System.assertEquals('Test Contact', [select Name from Opportunity where Name = 'Test Contact' and StageName = 'Not started' limit 1].Name, 'The opporunity was created susscefully');
    }
}

@isTest
public with sharing class TestTaskIntegration {
    @isTest static void dateAccount() {
        Task task = TestTaskFactory.createTaskAccount();

        Test.startTest();

        task.Status = 'Completed';
        upsert task;

        Test.stopTest();

        Account account = [select Last_Activity_Date__c from Account where Name = 'Test padre' limit 1];
        System.assertEquals(Date.today().addDays(20), account.Last_Activity_Date__c, 'La fecha se ha cambiado con exito');
    }

    @isTest static void dateOpportunity() {
        Task task = TestTaskFactory.createTaskOpportunity();

        Test.startTest();

        task.Status = 'Completed';
        upsert task;

        Test.stopTest();

        Account account = [select Last_Activity_Date__c from Account where Name = 'Test padre' limit 1];
        System.assertEquals(Date.today().addDays(20), account.Last_Activity_Date__c, 'La fecha se ha cambiado con exito');
    }
}

@isTest
public with sharing class TestTaskFactory {
    public static Task createTaskAccount() {
        Account accountFather = new Account(Name = 'Test padre');
        insert accountFather;

        Account account = new Account(Name = 'Test', ParentId = accountFather.Id);
        insert account;

        Task task = new Task(Subject = 'Call', ActivityDate = Date.today().addDays(20), WhatId = account.Id);
        insert task;
        return task;
    }

    public static Task createTaskOpportunity() {
        Account accountFather = new Account(Name = 'Test padre');
        insert accountFather;

        Account account = new Account(Name = 'Test', ParentId = accountFather.Id);
        insert account;

        Opportunity opportunity = new Opportunity(Name = 'Test opportunidad', CloseDate = Date.today(), StageName = 'Closed Won', AccountId = account.Id);
        insert opportunity;

        Task task = new Task(Subject = 'Call', ActivityDate = Date.today().addDays(20), WhatId = opportunity.Id);
        insert task;
        return task;
    }
}

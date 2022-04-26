public with sharing class TaskTriggerHandler implements ITrigger {
    //Var declaration
    Map<Id, Task> whatTask;
    List<Account> accounts = new List<Account>();
    //Constant declaration

    //Builder

    // Handler before methods

    /**
    * This method is called prior to execution of a BEFORE trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
    */
    public void bulkBefore() {

        whatTask = new Map<Id, Task>([select typeof What 
                    when Account then Id, Name, Last_Activity_Date__c, ParentId
                    when Opportunity then Id, Account.Last_Activity_Date__c, Account.ParentId
                END
            from Task where Id in :Trigger.new]);
    }

    public void beforeInsert(SObject sObj) {
        
    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {
        Task oldTask = (Task)oldSobj;
        Task newTask = (Task)sObj;

        if(newTask.Status == 'Completed' && oldTask.Status != 'Completed') {

            Account account;


            if(whatTask.get(newTask.Id).What instanceof Account) {
                account = (Account) whatTask.get(newTask.Id).What;
            }

            if(whatTask.get(newTask.Id).What instanceof Opportunity) {
                Opportunity opportunity = (Opportunity) whatTask.get(newTask.Id).What;
                account = opportunity.Account;
            }

            if(account.Parent != null) {
                if(account.Last_Activity_Date__c != null && account.Last_Activity_Date__c < newTask.ActivityDate) {
                    account.Last_Activity_Date__c = newTask.ActivityDate;
                } else {
                    account.Last_Activity_Date__c = newTask.ActivityDate;
                }

                accounts.add(account);
            }
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
        if(accounts != null) {
            upsert accounts;
        }
    }

    // Other methods
}

public class ExpenseController {
    @AuraEnabled
    public static List<Expense__c> getExpenses(){
        return[Select Id,name,Amount__c,client__c,Date__C,Reimbursed__C,createdDate from expense__c];
    }

}
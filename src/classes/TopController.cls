public with sharing class TopController {

    /////////////////////////////////////////
    // Actions
    /////////////////////////////////////////

    public PageReference get() {
        return new TopActions.GetHandler().setProperty(this).action();
    }

    /////////////////////////////////////////
    // Properties
    /////////////////////////////////////////
    public List<Product__c> products { get; set; }
    public List<Todo__c> todos { get; set; }

    /////////////////////////////////////////
    // Actions
    /////////////////////////////////////////
    public class GetHandler extends MyAppActionHandler {
        public override PageReference handleAction() {
            TopController ctrl = (TopController) properties;
            ctrl.todos = [SELECT Id, Name, Content__c, Done__c FROM Todo__c WHERE Contact__c = :session.contactId()];
            return null;
        }
    }
}

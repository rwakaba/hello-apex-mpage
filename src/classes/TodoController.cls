public with sharing class TodoController {

    /////////////////////////////////////////
    // Actions
    /////////////////////////////////////////

    public PageReference get() {
        return new GetHandler().setProperty(this).action();
    }
    public PageReference save() {
        return new SaveHandler().setProperty(this).action();
    }

    /////////////////////////////////////////
    // Properties
    /////////////////////////////////////////
    public Todo__c todo { get; set; }
    public ValidationResults vResult { get; set; }

    /////////////////////////////////////////
    // Actions
    /////////////////////////////////////////
    public class GetHandler extends MyAppActionHandler {
        public override void before() {
            setRule('id').caseNull(NotFound).caseIsNotSalesforceId(NotFound).check();
        }
        
        public override PageReference handleAction() {
            Id todoId = getParam.salesforceId('id');
            Todo__c todo = [SELECT Name, Content__c, Done__c FROM Todo__c WHERE Id = :todoId];

            if (todo == null) {
                throw new NoDataFoundException();
            }

            TodoController prop = (TodoController) properties;
            prop.todo = todo;
            return null;
        }
    }

    public class SaveHandler extends MyAppActionHandler {
        public override PageReference handleAction() {
            TodoController ctrl = (TodoController) properties;

            // validation
            DefaultValidator val = new DefaultValidator();
            val.checkRequired('title', ctrl.todo.Name);
            val.checkRequired('content', ctrl.todo.Content__c);

            if (val.results.hasError()) {
                ctrl.vResult = val.results;
                return null;
            }

            Todo__c edit = new Todo__c();
            edit.Id = ctrl.todo.Id;
            edit.Name = ctrl.todo.Name;
            edit.Content__c = ctrl.todo.Content__c;
            edit.Done__c = ctrl.todo.Done__c;
            update edit;

            PageReference p = Page.Top;
            p.setRedirect(true);
            return p;
        }
    }
}

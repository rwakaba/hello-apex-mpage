public with sharing class ProfileController {

    /////////////////////////////////////////
    // Actions
    /////////////////////////////////////////

    public PageReference get() {
        return new GetHandler().setProperty(this).action();
    }

    public PageReference submit() {
        return new SubmitHandler().setProperty(this).action();
    }

    /////////////////////////////////////////
    // Properties
    /////////////////////////////////////////
    public Contact contact { get; set; }

    public ValidationResults vResult { get; set; }
    //public CustomProfile__c p { get; set; }

    /////////////////////////////////////////
    // Actions
    /////////////////////////////////////////
    public class GetHandler extends MyAppActionHandler {
        public override PageReference handleAction() {
            Id contactId = session.contactId();
            Contact c = [SELECT LastName, FirstName FROM Contact WHERE Id = :contactId];

            ProfileController ctrl = (ProfileController) properties;
            ctrl.contact = c;
            return null;
        }
    }

    public class SubmitHandler extends MyAppActionHandler {
        public override PageReference handleAction() {
            ProfileController ctrl = (ProfileController) properties;

            // validation
            DefaultValidator val = new DefaultValidator();
            val.checkRequired('lastName', ctrl.contact.LastName);
            val.checkRequired('firstName', ctrl.contact.FirstName);

            if (val.results.hasError()) {
                ctrl.vResult = val.results;
                return null;
            }

            Contact edit = new Contact();
            edit.Id = session.contactId();
            edit.LastName = ctrl.contact.LastName;
            edit.FirstName = ctrl.contact.FirstName;
            update edit;

            PageReference p = Page.Profile;
            p.setRedirect(true);
            return p;
        }
    }
}

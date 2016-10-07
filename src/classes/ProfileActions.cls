public class ProfileActions {

    /**
     * Get Sample.
     */
    public class GetHandler extends MyAppActionHandler {
        public override PageReference handleAction() {
            Id contactId = session.contactId();
            Contact c = [SELECT LastName, FirstName FROM Contact WHERE Id = :contactId];

            ProfileController ctrl = (ProfileController) property;
            ctrl.contact = c;
            return null;
        }
    }

    /**
     * Post Sample.
     */
    public class SubmitHandler extends MyAppActionHandler {
        public override PageReference handleAction() {
            ProfileController ctrl = (ProfileController) property;

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

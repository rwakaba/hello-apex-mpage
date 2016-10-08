public class SampleActions {

    /**
     * Get Sample.
     */
    public class GetHandler extends MyAppActionHandler {
        public override void before() {
            setRule('id').caseNull(NotFound).caseIsNotSalesforceId(NotFound).check();
        }
        
        public override PageReference handleAction() {
            Id accountId = getParam.salesforceId('id');
            Account a = [SELECT name FROM Account WHERE Id = :accountId];

            if (a == null) {
                throw new NoDataFoundException();
            }

            SampleProperty prop = (SampleProperty) property;
            prop.myAccount = a;
            return null;
        }
    }

    /**
     * Get Sample.
     */
    public class SearchHandler extends MyAppActionHandler {
        public override void before() {
            setRule('limit').caseNull(Ignore).caseIsNotInteger(BadRequest).check();
            setRule('offset').caseNull(Ignore).caseIsNotInteger(BadRequest).check();
        }

        public override PageReference handleAction() {
            String q = getParam.get('q');
            if (String.isBlank(q)) { return null; }

            SampleProperty prop = (SampleProperty) property;
            prop.q = q;
            prop.offset = getParam.intValue('offset', 0);
            prop.limitSize = getParam.intValue('limit', 50);

            String accountName = q + '%';
            prop.accounts = [SELECT Id, Name FROM Account 
                WHERE Name LIKE :accountName
                LIMIT :prop.limitSize
                OFFSET :prop.offset];
            return null;
        }
    }

    //Get Sample.(Get My-Page-Data from session.)
    public class GetStateFullRequestHandler extends MyAppActionHandler {
        public override PageReference handleAction() {
                return null;
        }
    }

    /**
     * Post Sample.
     */
    public class ConfirmHandler extends MyAppActionHandler {
        public override PageReference handleAction() {
            return null;
        }

    }

    /**
     * Post and Redirect Sample.
     */
    public class SaveHandler extends MyAppActionHandler {
        public override PageReference handleAction() {
            return null;
        }
    }

}

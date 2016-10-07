public with sharing class ProfileController {

    /////////////////////////////////////////
    // Actions
    /////////////////////////////////////////

    public PageReference get() {
        return new ProfileActions.GetHandler().setProperty(this).action();
    }

    public PageReference submit() {
        return new ProfileActions.SubmitHandler().setProperty(this).action();
    }

    /////////////////////////////////////////
    // Properties
    /////////////////////////////////////////
    public Contact contact { get; set; }

    public ValidationResults vResult { get; set; }
    //public CustomProfile__c p { get; set; }
}

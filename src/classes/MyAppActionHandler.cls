public abstract class MyAppActionHandler extends ActionHandler {

    protected final ParameterCheckRule.CheckThen BadRequest = ParameterCheckRule.CheckThen.BadRequest;
    protected final ParameterCheckRule.CheckThen NotFound = ParameterCheckRule.CheckThen.NotFound;
    protected final ParameterCheckRule.CheckThen Ignore = ParameterCheckRule.CheckThen.Ignore;
    
    public virtual override void before() {
    }
    
    protected ParameterCheck setRule(String paramName) {
        ParameterCheck rule = new ParameterCheck(paramName);
        return rule;
    }
    
    protected AppSession session {
        get {
            return AppSession.getInstance();
        }
    }

    public override void after() {
    }

    public override PageReference handleException(Exception e) {
        //throw e;
        PageReference p= Page.DebugPage;
        p.setRedirect(true);
        p.getParameters().put('message', e.getMessage());
        p.getParameters().put('typeName', e.getTypeName());
        p.getParameters().put('stacktrace', e.getStackTraceString());
        return p;
    }
}

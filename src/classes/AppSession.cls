public class AppSession extends Session {

    private AppSession() {
    }

    private static AppSession sess;

    public static AppSession getInstance() {
        if (sess == null) {
            sess = new AppSession();
        }
        return sess;
    }

    public override Id fakeContactId() {
        return '0032800000UPf5W';
    }

    public override Id slaveId() {
        return null;
    }

    public Id recordId {
        get {
            return null;
        }
    }
}

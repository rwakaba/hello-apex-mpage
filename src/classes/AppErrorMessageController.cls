public class AppErrorMessageController extends ErrorMessageController {
    protected override ValidationErrorFormat errorFormat() {
        return new AppValidationErrorFormat();
    }
}

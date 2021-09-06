protocol ResetPasswordPresenterProtocol: AnyObject {
    func reset(email: String)
    func toAuthentication()
}

class ResetPasswordPresenter:  ResetPasswordPresenterProtocol {
    weak var view:  ResetPasswordViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()

    init(view:  ResetPasswordViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter
    }

    // Авторизация пользователя
    func reset(email: String) {
        
        // Проверка введенных данных на валидность
        guard DataValidator.emailIsValid(email) else {
            view?.showWarning(title: "Ошибочка!", text: "Электронная почта не соответствует общепринятому формату.")
            return
        }

        firebaseManager.resetPassword(email: email) { [weak self] error in
            guard error == nil else {
                self?.view?.showWarning(title: "Ошибочка!", text: error!)
                return
            }

            self?.moduleRouter.dissmiss()
        }

    }

    // Переход к окну регистрации
    func toAuthentication() {
        moduleRouter.dissmiss()
    }
}


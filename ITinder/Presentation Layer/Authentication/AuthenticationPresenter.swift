import UIKit

protocol AuthenticationPresenterProtocol: AnyObject {
    func authenticate(email: String, password: String)
    func toRegistration()
    func toResetPassword()
}

class AuthenticationPresenter: AuthenticationPresenterProtocol {
    weak var view: AuthenticationViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()

    init(view: AuthenticationViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter

    }

    // Авторизация пользователя
    func authenticate(email: String, password: String) {

        // Проверка введенных данных на валидность
        guard DataValidator.emailIsValid(email) else {
            view?.showWarning(title: "Ошибочка!", text: "Электронная почта не соответствует общепринятому формату.")
            return
        }

        guard DataValidator.passwordIsValid(password) else {
            view?.showWarning(title: "Ошибочка!", text: "Пароль короче 6 символов.")
            return
        }

        view?.hideWarning()

        firebaseManager.signIn(email: email, password: password) { [weak self] user, error in
            guard let user = user, error == nil else {
                self?.view?.showWarning(title: "Ошибочка!", text: error ?? "")
                return
            }

            self?.view?.hideWarning()

            User.currentUser = user

            if user.registrationIsFinished ?? false {
                self?.moduleRouter.toMainApplicationModule()
            } else {
                self?.moduleRouter.toAbout()
            }
        }
    }

    // Переход к окну регистрации
    func toRegistration() {
        moduleRouter.toRegistration(authenticationModule: self)
    }

    func toResetPassword() {
        moduleRouter.toResetPassword()
    }
}


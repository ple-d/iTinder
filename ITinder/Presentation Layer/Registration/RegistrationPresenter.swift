import UIKit

protocol RegistrationPresenterProtocol: AnyObject {
    func register(name: String, email: String, password: String, imageData: Data, isMale: Bool)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var view: RegistrationViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()
    private let authenticationModule: AuthenticationPresenterProtocol

    init(view: RegistrationViewProtocol, moduleRouter: ModuleRouterProtocol, authenticationModule: AuthenticationPresenterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter
        self.authenticationModule = authenticationModule
    }

    // Регистрация пользователя в системе (первый этап)
    func register(name: String, email: String, password: String, imageData: Data, isMale: Bool) {
        guard DataValidator.usernameIsValid(name) else {
            view?.showWarning(title: "Ошибочка!", text: "Страненькое у вас имя. Нигде не ошиблись?")
            return
        }
        guard DataValidator.emailIsValid(email) else {
            view?.showWarning(title: "Ошибочка!", text: "Электронная почта не соответствует общепринятому формату.")
            return
        }
        guard DataValidator.passwordIsValid(password) else {
            view?.showWarning(title: "Ошибочка!", text: "Пароль короче 6 символов.")
            return
        }

        let user = User(name: name, email: email, password: password, isMale: isMale)
        user.imageDictionary["avatar"] = imageData

        firebaseManager.signUp(user: user) { [weak self] error in
            guard error == nil else {
                self?.view?.showWarning(title: "Ошибочка!", text: error!)
                return
            }

            self?.authenticationModule.authenticate(email: email, password: password)
            self?.moduleRouter.dissmiss()
        }
    }
}

protocol ChangePasswordPresenterProtocol: AnyObject {
    func change(oldPassword: String, newPassword: String)
}

class ChangePasswordPresenter:  ChangePasswordPresenterProtocol {
    weak var view:  ChangePasswordViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()

    init(view:  ChangePasswordViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter
    }

    // Изменение пароля
    func change(oldPassword: String, newPassword: String){
        guard oldPassword == User.currentUser?.password ?? "" else {
            view?.showWarning(title: "Ошибочка!", text: "Текущий пароль не верный. Вы можете его восстановить на экране авторизации.")
            return
        }

        // Проверка введенных данных на валидность
        guard DataValidator.passwordIsValid(newPassword) else {
            view?.showWarning(title: "Ошибочка!", text: "Новый пароль короче 6 символов.")
            return
        }

        firebaseManager.changePassword(id: User.currentUser?.id ?? "", password: newPassword) { [weak self] error in
            guard error == nil else {
                self?.view?.showWarning(title: "Ошибочка!", text: error!)
                return
            }

            User.currentUser?.password = newPassword
            self?.moduleRouter.dissmiss()
        }

    }


}

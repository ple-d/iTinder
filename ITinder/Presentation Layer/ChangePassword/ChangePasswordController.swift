import UIKit

protocol ChangePasswordViewProtocol: AnyObject {
    func showWarning(title: String, text: String)
    func hideWarning()
}

class ChangePasswordController: UIViewController, ChangePasswordViewProtocol {
    var presenter: ChangePasswordPresenterProtocol?

    override func loadView() {
        view = ChangePasswordView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = view as? ChangePasswordView

        view?.changeButton.addTarget(self, action: #selector(changeButtonTouched), for: .touchUpInside)

    }

    // Метод вызывается при нажатии на кнопку "Войти"
    @objc private func changeButtonTouched() {
        let view = view as? ChangePasswordView

        guard let oldPassword = view?.oldPasswordTextField.text else {
            return
        }

        guard let newPassword = view?.newPasswordTextField.text else {
            return
        }

        guard let repeatNewPassword = view?.repeatNewPasswordTextField.text, repeatNewPassword == newPassword else {
            showWarning(title: "Ошибочка", text: "Новые пароли не совпадают.")
            return
        }

        presenter?.change(oldPassword: oldPassword, newPassword: newPassword)
    }

    // Метод для показа предупреждения
    func showWarning(title: String, text: String) {
        let view = view as? ChangePasswordView

        view?.warningView.show(title: title, text: text)
    }

    // Метод для скрытия предупреждения
    func hideWarning()  {
        let view = view as? ChangePasswordView
        view?.warningView.hide() {}
    }
}

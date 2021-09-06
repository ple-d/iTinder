import UIKit

protocol AuthenticationViewProtocol: AnyObject {
    func showWarning(title: String, text: String)
    func hideWarning()
}

class AuthenticationController: UIViewController, AuthenticationViewProtocol {
    var presenter: AuthenticationPresenterProtocol?

    override func loadView() {
        view = AuthenticationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = view as? AuthenticationView

        view?.authenticationButton.addTarget(self, action: #selector(authenticationButtonTouched), for: .touchUpInside)
        
        let toRegistrationTap = UITapGestureRecognizer(target: self, action: #selector(toRegistrationTouched))
        view?.toRegistrationActionLabel.addGestureRecognizer(toRegistrationTap)

        let toResetPasswordTap = UITapGestureRecognizer(target: self, action: #selector(toResetPasswordTouched))
        view?.toResetPasswordActionLabel.addGestureRecognizer(toResetPasswordTap)
    }

    // Метод вызывается при нажатии на кнопку "Войти"
    @objc private func authenticationButtonTouched() {
        let view = view as? AuthenticationView

        guard let email = view?.emailTextField.text else {
            return
        }
        guard let password = view?.passwordTextField.text else {
            return
        }

        presenter?.authenticate(email: email, password: password)
    }

    // Метод вызывается при нажатии на надпись "Зарегистрируйся!"
    @objc private func toRegistrationTouched() {
        presenter?.toRegistration()
    }

    // Метод вызывается при нажатии на надпись "Зарегистрируйся!"
    @objc private func toResetPasswordTouched() {
        presenter?.toResetPassword()
    }

    // Метод для показа предупреждения
    func showWarning(title: String, text: String) {
        let view = view as? AuthenticationView

        view?.warningView.show(title: title, text: text)
    }

    // Метод для скрытия предупреждения
    func hideWarning()  {
        let view = view as? AuthenticationView
        view?.warningView.hide() {}
    }
}



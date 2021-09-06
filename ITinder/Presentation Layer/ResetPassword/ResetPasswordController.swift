import UIKit

protocol ResetPasswordViewProtocol: AnyObject {
    func showWarning(title: String, text: String)
    func hideWarning()
}

class ResetPasswordController: UIViewController, ResetPasswordViewProtocol {
    var presenter: ResetPasswordPresenterProtocol?

    override func loadView() {
        view = ResetPasswordView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = view as? ResetPasswordView

        view?.resetButton.addTarget(self, action: #selector(resetButtonTouched), for: .touchUpInside)

    }

    // Метод вызывается при нажатии на кнопку "Войти"
    @objc private func resetButtonTouched() {
        let view = view as? ResetPasswordView

        guard let email = view?.emailTextField.text else {
            return
        }

        presenter?.reset(email: email)
    }

    // Метод для показа предупреждения
    func showWarning(title: String, text: String) {
        let view = view as? ResetPasswordView

        view?.warningView.show(title: title, text: text)
    }

    // Метод для скрытия предупреждения
    func hideWarning()  {
        let view = view as? ResetPasswordView
        view?.warningView.hide() {}
    }
}

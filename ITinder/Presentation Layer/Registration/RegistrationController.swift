import UIKit

protocol RegistrationViewProtocol: AnyObject {
    func showWarning(title: String, text: String)
    func hideWarning()
}

class RegistrationController: UIViewController, RegistrationViewProtocol {
    var presenter: RegistrationPresenterProtocol?
    
    private let imagePicker = UIImagePickerController()
    private var userImageData: Data?

    override func loadView() {
        view = RegistrationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = view as? RegistrationView

        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        view?.registrationButton.addTarget(self, action: #selector(registrationButtonTouched), for: .touchUpInside)
        view?.addUserImageButton.addTarget(self, action: #selector(addUserImageButtonTouched), for: .touchUpInside)
    }

    //Нажатие на кнопку регистрации
    @objc private func registrationButtonTouched() {
        let view = view as? RegistrationView

        guard let userImageData = userImageData else {
            showWarning(title: "Ошибочка!", text: "Добавьте свою симпотичную мордашку. Пусть другие любуются.")
            return
        }

        guard let name = view?.nameTextField.text else {
            return
        }
        guard let email = view?.emailTextField.text else {
            return
        }
        guard let password = view?.passwordTextField.text else {
            return
        }

        let isMale = view?.genderSegmentedControl.selectedSegmentIndex == 0
        
        presenter?.register(name: name, email: email, password: password, imageData: userImageData, isMale: isMale)
    }

    @objc private func addUserImageButtonTouched() {
        present(imagePicker, animated: true)
    }

    // Метод для показа предупреждения
    func showWarning(title: String, text: String) {
        let view = view as? RegistrationView

        view?.warningView.show(title: title, text: text)
    }

    // Метод для скрытия предупреждения
    func hideWarning()  {
        let view = view as? RegistrationView
        view?.warningView.hide() {}
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let view = self.view as! RegistrationView

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            view.userImageView.image = image
            userImageData = image.jpegData(compressionQuality: 0.4)
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

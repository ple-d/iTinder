import UIKit

class RegistrationView: UIView {

    // Фон
    let background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = UIImage(named: "background")
        return background
    }()

    func backgroundConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.rightAnchor.constraint(equalTo: rightAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            background.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }

    // Контейнер-тень для аватарки
    let userImageContainer: UIView = {
        let userImageContainer = UIView()
        userImageContainer.translatesAutoresizingMaskIntoConstraints = false

        userImageContainer.layer.shadowColor = UIColor.black.cgColor
        userImageContainer.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        userImageContainer.layer.shadowOpacity = 0.15
        userImageContainer.layer.shadowRadius = 2.0

        return userImageContainer
    }()

    func userImageContainerConstraints() {
        NSLayoutConstraint.activate([
            userImageContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImageContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            userImageContainer.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            userImageContainer.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height / 16)
        ])
    }

    // Аватарка
    let userImageView: UIImageView = {
        let userImageView = UIImageView(image: UIImage(named: "avatar_thumbnail"))
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.clipsToBounds = true


        return userImageView
    }()

    func userImageViewConstraints() {
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalTo: userImageContainer.widthAnchor),
            userImageView.heightAnchor.constraint(equalTo: userImageContainer.heightAnchor),
        ])
    }

    // Кнопка добавления аватарки
    let addUserImageButton: UIGradientButton = {
        let addUserImageButton = UIGradientButton()
        addUserImageButton.translatesAutoresizingMaskIntoConstraints = false

        addUserImageButton.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        addUserImageButton.setTitleColor(.white, for: .normal)
        addUserImageButton.setTitle("+", for: .normal)
        addUserImageButton.titleLabel?.font = UIFont(name: "Helvetica", size: UIScreen.main.bounds.height * 0.025)

        addUserImageButton.layer.shadowColor = UIColor.black.cgColor
        addUserImageButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addUserImageButton.layer.shadowOpacity = 0.15
        addUserImageButton.layer.shadowRadius = 2.0

        return addUserImageButton
    }()

    func addUserImageButtonConstraints() {
        NSLayoutConstraint.activate([
            addUserImageButton.rightAnchor.constraint(equalTo: userImageContainer.rightAnchor, constant: -UIScreen.main.bounds.width * 0.125 * 0.22),
            addUserImageButton.bottomAnchor.constraint(equalTo: userImageContainer.bottomAnchor, constant: -UIScreen.main.bounds.width * 0.125 * 0.22),
            addUserImageButton.widthAnchor.constraint(equalTo: userImageContainer.widthAnchor, multiplier: 0.22),
            addUserImageButton.heightAnchor.constraint(equalTo: userImageContainer.widthAnchor, multiplier: 0.22)
        ])
    }

    // SegmentedControl для выбора пола
    let genderSegmentedControl: UISegmentedControl = {
        let genderSegmentedControl = UISegmentedControl(items: ["Мужской", "Женский"])
        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        genderSegmentedControl.selectedSegmentIndex = 0
        genderSegmentedControl.selectedSegmentTintColor = appColor.pink
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: appColor.gray]
        genderSegmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)

        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        genderSegmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)

        let titleTextAttributes2 = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.022)]
        genderSegmentedControl.setTitleTextAttributes(titleTextAttributes2, for: .normal)

        genderSegmentedControl.layer.masksToBounds = false
        genderSegmentedControl.layer.shadowColor = UIColor.black.cgColor
        genderSegmentedControl.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        genderSegmentedControl.layer.shadowOpacity = 0.15
        genderSegmentedControl.layer.shadowRadius = 2.0

        return genderSegmentedControl
    }()

    func genderSegmentedControlConstraints() {
        NSLayoutConstraint.activate([
            genderSegmentedControl.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            genderSegmentedControl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            genderSegmentedControl.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.12),
            genderSegmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Текстовое поле "Ваше имя"
    let nameTextField: UIGradientTextField = {
        let nameTextField = UIGradientTextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.backgroundColor = .white
        nameTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        nameTextField.textColor = appColor.black
        nameTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        nameTextField.placeholderLabel.text = "Ваше имя    \u{200c}"
        nameTextField.autocorrectionType = .no

        return nameTextField
    }()

    func nameTextFieldConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            nameTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
            nameTextField.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Текстовое поле "Электронная почта'"
    let emailTextField: UIGradientTextField = {
        let emailTextField = UIGradientTextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.backgroundColor = .white
        emailTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        emailTextField.textColor = appColor.black
        emailTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        emailTextField.placeholderLabel.text = "Электронная почта    \u{200c}"
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no

        return emailTextField
    }()

    func emailTextFieldConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            emailTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Текстовое поле "Пароль"
    let passwordTextField: UIGradientTextField = {
        let passwordTextField = UIGradientTextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .white
        passwordTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        passwordTextField.textColor = appColor.black
        passwordTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        passwordTextField.placeholderLabel.text = "Пароль    \u{200c}"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true

        return passwordTextField
    }()

    func passwordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            passwordTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Кнопка "Далее"
    let registrationButton: UIGradientButton = {
        let registrationButton = UIGradientButton()
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        registrationButton.setTitleColor(.white, for: .normal)
        registrationButton.setTitle("Далее", for: .normal)
        registrationButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return registrationButton
    }()

    func registrationButtonConstraints() {
        NSLayoutConstraint.activate([
            registrationButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            registrationButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
            registrationButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            registrationButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Логотип
    let gradientLogo: UIGradientLabel = {
        let gradientLogo = UIGradientLabel()
        gradientLogo.translatesAutoresizingMaskIntoConstraints = false
        gradientLogo.text = "ITinder"
        gradientLogo.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        gradientLogo.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)
        gradientLogo.addShadow()

        return gradientLogo
    }()

    func gradientLogoConstraints() {
        NSLayoutConstraint.activate([
            gradientLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            gradientLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 16)
        ])
    }

    // Поп-ап
    let warningView: UIWarningView = {
        let warningView = UIWarningView()
        warningView.translatesAutoresizingMaskIntoConstraints = false

        return warningView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(background)
        backgroundConstraints()

        addSubview(userImageContainer)
        userImageContainerConstraints()

        userImageContainer.addSubview(userImageView)
        userImageViewConstraints()

        addSubview(addUserImageButton)
        addUserImageButtonConstraints()

        addSubview(genderSegmentedControl)
        genderSegmentedControlConstraints()

        addSubview(nameTextField)
        nameTextFieldConstraints()

        addSubview(emailTextField)
        emailTextFieldConstraints()

        addSubview(passwordTextField)
        passwordTextFieldConstraints()

        addSubview(registrationButton)
        registrationButtonConstraints()

        addSubview(gradientLogo)
        gradientLogoConstraints()

        addSubview(warningView)
        warningView.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()

        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        userImageContainer.layer.shadowPath = UIBezierPath(roundedRect: userImageView.bounds, cornerRadius: userImageView.bounds.height / 2).cgPath
        addUserImageButton.layer.cornerRadius = addUserImageButton.bounds.height / 2
        nameTextField.layer.cornerRadius = nameTextField.bounds.height / 2
        emailTextField.layer.cornerRadius = emailTextField.bounds.height / 2
        passwordTextField.layer.cornerRadius = emailTextField.bounds.height / 2
    }
}

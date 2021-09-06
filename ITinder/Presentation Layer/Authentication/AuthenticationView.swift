import UIKit

class AuthenticationView: UIView {

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

    // StackView для отцентровки формы авторизации на экране
    let authenticationFormStackView: UIStackView = {
        let authenticationFormStackView = UIStackView()
        authenticationFormStackView.translatesAutoresizingMaskIntoConstraints = false
        authenticationFormStackView.alignment = .center
        authenticationFormStackView.axis = .vertical
        authenticationFormStackView.spacing = UIScreen.main.bounds.height * 0.033

        return authenticationFormStackView
    }()

    func authenticationFormStackViewConstraints() {
        NSLayoutConstraint.activate([
            authenticationFormStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            authenticationFormStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    // Заголовок "Войди и ищи"
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Войди и ищи"
        title.textAlignment = .center
        title.textColor = appColor.black
        title.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)

        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        title.layer.shadowOpacity = 0.15
        title.layer.shadowRadius = 2.0
        
        return title
    }()

    // Текстовое поле "Электронная почта"
    let emailTextField: UIGradientTextField = {
        let emailTextField = UIGradientTextField()
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
        ])
    }

    // Текстовое поле "Пароль"
    let passwordTextField: UIGradientTextField = {
        let passwordTextField = UIGradientTextField()
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
        ])
    }

    // Кнопка "Войти"
    let authenticationButton: UIGradientButton = {
        let authenticationButton = UIGradientButton()
        authenticationButton.translatesAutoresizingMaskIntoConstraints = false
        authenticationButton.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        authenticationButton.setTitleColor(.white, for: .normal)
        authenticationButton.setTitle("Войти", for: .normal)
        authenticationButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return authenticationButton
    }()

    func authenticationButtonConstraints() {
        NSLayoutConstraint.activate([
            authenticationButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            authenticationButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
        ])
    }

    // StackView для отцентровки надписей "Нет аккаунта? Зарегистрируйся!"
    let toRegistrationStackView: UIStackView = {
        let toRegistrationStackView = UIStackView()
        toRegistrationStackView.translatesAutoresizingMaskIntoConstraints = false
        toRegistrationStackView.alignment = .center
        toRegistrationStackView.axis = .horizontal
        toRegistrationStackView.spacing = UIScreen.main.bounds.width * 0.02

        return toRegistrationStackView
    }()

    // Надпись "Нет аккаунта?"
    let toRegistrationLabel: UILabel = {
        let toRegistrationLabel = UILabel()
        toRegistrationLabel.translatesAutoresizingMaskIntoConstraints = false
        toRegistrationLabel.text = "Нет аккаунта?"
        toRegistrationLabel.textAlignment = .center
        toRegistrationLabel.textColor = UIColor(red: 0.696, green: 0.696, blue: 0.696, alpha: 1)
        toRegistrationLabel.font = UIFont(name: "HelveticaNeue-Medium", size: UIScreen.main.bounds.height * 0.018)


        return toRegistrationLabel
    }()

    // Надпись "Зарегистрируйся!"
    let toRegistrationActionLabel: UIGradientLabel = {
        let toRegistrationActionLabel = UIGradientLabel()
        toRegistrationActionLabel.translatesAutoresizingMaskIntoConstraints = false
        toRegistrationActionLabel.isUserInteractionEnabled = true
        toRegistrationActionLabel.text = "Зарегистрируйся!"
        toRegistrationActionLabel.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        toRegistrationActionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: UIScreen.main.bounds.height * 0.018)

        return toRegistrationActionLabel
    }()

    // Надпись "Зарегистрируйся!"
    let toResetPasswordActionLabel: UIGradientLabel = {
        let toResetPasswordActionLabel = UIGradientLabel()
        toResetPasswordActionLabel.translatesAutoresizingMaskIntoConstraints = false
        toResetPasswordActionLabel.isUserInteractionEnabled = true
        toResetPasswordActionLabel.text = "Я забыл пароль"
        toResetPasswordActionLabel.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        toResetPasswordActionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: UIScreen.main.bounds.height * 0.018)

        return toResetPasswordActionLabel
    }()

    // Логотип
    let gradientLogo: UIGradientLabel = {
        let gradientLogo = UIGradientLabel()
        gradientLogo.translatesAutoresizingMaskIntoConstraints = false
        gradientLogo.text = "ITinder"
        gradientLogo.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        gradientLogo.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)
        
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

        addSubview(authenticationFormStackView)
        authenticationFormStackViewConstraints()

        authenticationFormStackView.addArrangedSubview(title)

        authenticationFormStackView.setCustomSpacing(UIScreen.main.bounds.height * 0.045, after: title)

        authenticationFormStackView.addArrangedSubview(emailTextField)
        emailTextFieldConstraints()

        authenticationFormStackView.addArrangedSubview(passwordTextField)
        passwordTextFieldConstraints()

        authenticationFormStackView.addArrangedSubview(authenticationButton)
        authenticationButtonConstraints()

        authenticationFormStackView.addArrangedSubview(toRegistrationStackView)

        toRegistrationStackView.addArrangedSubview(toRegistrationLabel)
        toRegistrationStackView.addArrangedSubview(toRegistrationActionLabel)

        authenticationFormStackView.addArrangedSubview(toResetPasswordActionLabel)
        
        addSubview(gradientLogo)
        gradientLogoConstraints()

        addSubview(warningView)
        warningView.setup()
    }

    override required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        emailTextField.layer.cornerRadius = emailTextField.bounds.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.bounds.height / 2
    }
}

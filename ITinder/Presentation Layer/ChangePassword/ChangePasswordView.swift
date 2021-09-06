import UIKit

class ChangePasswordView: UIView {

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
    let resetFormStackView: UIStackView = {
        let resetFormStackView = UIStackView()
        resetFormStackView.translatesAutoresizingMaskIntoConstraints = false
        resetFormStackView.alignment = .center
        resetFormStackView.axis = .vertical
        resetFormStackView.spacing = UIScreen.main.bounds.height * 0.033

        return resetFormStackView
    }()

    func resetFormStackViewConstraints() {
        NSLayoutConstraint.activate([
            resetFormStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            resetFormStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    // Заголовок "Изменение пароля"
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Изменение пароля"
        title.textAlignment = .center
        title.textColor = appColor.black
        title.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)

        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        title.layer.shadowOpacity = 0.15
        title.layer.shadowRadius = 2.0

        return title
    }()

    // Текстовое поле "Текущий пароль"
    let oldPasswordTextField: UIGradientTextField = {
        let oldPasswordTextField = UIGradientTextField()
        oldPasswordTextField.backgroundColor = .white
        oldPasswordTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        oldPasswordTextField.textColor = appColor.black
        oldPasswordTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        oldPasswordTextField.placeholderLabel.text = "Текущий пароль    \u{200c}"
        oldPasswordTextField.autocapitalizationType = .none
        oldPasswordTextField.autocorrectionType = .no
        oldPasswordTextField.isSecureTextEntry = true

        return oldPasswordTextField
    }()

    func oldPasswordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            oldPasswordTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            oldPasswordTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
        ])
    }

    // Текстовое поле "Новый пароль"
    let newPasswordTextField: UIGradientTextField = {
        let newPasswordTextField = UIGradientTextField()
        newPasswordTextField.backgroundColor = .white
        newPasswordTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        newPasswordTextField.textColor = appColor.black
        newPasswordTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        newPasswordTextField.placeholderLabel.text = "Новый пароль    \u{200c}"
        newPasswordTextField.autocapitalizationType = .none
        newPasswordTextField.autocorrectionType = .no
        newPasswordTextField.isSecureTextEntry = true

        return newPasswordTextField
    }()

    func newPasswordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            newPasswordTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            newPasswordTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
        ])
    }

    // Текстовое поле "Еще разочек"
    let repeatNewPasswordTextField: UIGradientTextField = {
        let repeatNewPasswordTextField = UIGradientTextField()
        repeatNewPasswordTextField.backgroundColor = .white
        repeatNewPasswordTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        repeatNewPasswordTextField.textColor = appColor.black
        repeatNewPasswordTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        repeatNewPasswordTextField.placeholderLabel.text = "Ещё разочек    \u{200c}"
        repeatNewPasswordTextField.autocapitalizationType = .none
        repeatNewPasswordTextField.autocorrectionType = .no
        repeatNewPasswordTextField.isSecureTextEntry = true

        return repeatNewPasswordTextField
    }()

    func repeatNewPasswordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            repeatNewPasswordTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            repeatNewPasswordTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
        ])
    }

    // Кнопка "Изменить"
    let changeButton: UIGradientButton = {
        let changeButton = UIGradientButton()
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        changeButton.setTitleColor(.white, for: .normal)
        changeButton.setTitle("Изменить", for: .normal)
        changeButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return changeButton
    }()

    func changeButtonConstraints() {
        NSLayoutConstraint.activate([
            changeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            changeButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
        ])
    }

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

        addSubview(resetFormStackView)
        resetFormStackViewConstraints()

        resetFormStackView.addArrangedSubview(title)

        resetFormStackView.setCustomSpacing(UIScreen.main.bounds.height * 0.045, after: title)

        resetFormStackView.addArrangedSubview(oldPasswordTextField)
        oldPasswordTextFieldConstraints()

        resetFormStackView.addArrangedSubview(newPasswordTextField)
        newPasswordTextFieldConstraints()

        resetFormStackView.addArrangedSubview(repeatNewPasswordTextField)
        repeatNewPasswordTextFieldConstraints()

        resetFormStackView.addArrangedSubview(changeButton)
        changeButtonConstraints()

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

        oldPasswordTextField.layer.cornerRadius = oldPasswordTextField.bounds.height / 2
        newPasswordTextField.layer.cornerRadius = newPasswordTextField.bounds.height / 2
        repeatNewPasswordTextField.layer.cornerRadius = repeatNewPasswordTextField.bounds.height / 2
    }
}

import UIKit

class ResetPasswordView: UIView {

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

    // Заголовок "Мы отправим письмо"
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Мы отправим письмо"
        title.textAlignment = .center
        title.textColor = Color.black
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
        emailTextField.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        emailTextField.textColor = Color.black
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

    // Кнопка "Войти"
    let resetButton: UIGradientButton = {
        let resetButton = UIGradientButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.setTitle("Воccтановить", for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return resetButton
    }()

    func resetButtonConstraints() {
        NSLayoutConstraint.activate([
            resetButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            resetButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
        ])
    }

    // Логотип
    let gradientLogo: UIGradientLabel = {
        let gradientLogo = UIGradientLabel()
        gradientLogo.translatesAutoresizingMaskIntoConstraints = false
        gradientLogo.text = "ITinder"
        gradientLogo.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
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

        resetFormStackView.addArrangedSubview(emailTextField)
        emailTextFieldConstraints()

        resetFormStackView.addArrangedSubview(resetButton)
        resetButtonConstraints()

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
    }
}

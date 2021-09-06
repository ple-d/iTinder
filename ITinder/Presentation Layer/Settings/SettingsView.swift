import UIKit

class SettingsView: UIView {

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

    // Заголовок "Настройки"
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Настройки"
        title.textAlignment = .center
        title.textColor = Color.black
        title.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)

        return title
    }()

    func titleConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height / 16),
            title.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // StackView для отцентровки
    let settingsStackView: UIStackView = {
        let settingsStackView = UIStackView()
        settingsStackView.translatesAutoresizingMaskIntoConstraints = false
        settingsStackView.alignment = .center
        settingsStackView.axis = .vertical
        settingsStackView.spacing = UIScreen.main.bounds.height * 0.033

        return settingsStackView
    }()

    func settingsStackViewConstraints() {
        NSLayoutConstraint.activate([
            settingsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            settingsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    // Заголовок "Дистанция поиска"
    let distanceTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Дистанция поиска"
        title.textAlignment = .center
        title.textColor = Color.black
        title.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        title.layer.shadowOpacity = 0.15
        title.layer.shadowRadius = 2.0

        return title
    }()

    // SegmentedControl для выбора дистанции
    let distanceSegmentedControl: UISegmentedControl = {
        let distanceSegmentedControl = UISegmentedControl(items: ["20", "100", "1000", "∞"])
        distanceSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        distanceSegmentedControl.selectedSegmentIndex = 0
        distanceSegmentedControl.selectedSegmentTintColor = Color.pink
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.gray]
        distanceSegmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)

        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        distanceSegmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)

        let titleTextAttributes2 = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.022)]
        distanceSegmentedControl.setTitleTextAttributes(titleTextAttributes2, for: .normal)

        distanceSegmentedControl.layer.masksToBounds = false
        distanceSegmentedControl.layer.shadowColor = UIColor.black.cgColor
        distanceSegmentedControl.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        distanceSegmentedControl.layer.shadowOpacity = 0.15
        distanceSegmentedControl.layer.shadowRadius = 2.0

        return distanceSegmentedControl
    }()

    func distanceSegmentedControlConstraints() {
        NSLayoutConstraint.activate([
            distanceSegmentedControl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            distanceSegmentedControl.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.12),
        ])
    }

    // Надпись "Обновить геолокацию"
    let updateLocationActionLabel: UIGradientLabel = {
        let updateLocationActionLabel = UIGradientLabel()
        updateLocationActionLabel.translatesAutoresizingMaskIntoConstraints = false
        updateLocationActionLabel.isUserInteractionEnabled = true
        updateLocationActionLabel.text = "Обновить геолокацию"
        updateLocationActionLabel.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        updateLocationActionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: UIScreen.main.bounds.height * 0.018)

        return updateLocationActionLabel
    }()

    // Надпись "Изменить пароль"
    let changePasswordActionLabel: UIGradientLabel = {
        let changePasswordActionLabel = UIGradientLabel()
        changePasswordActionLabel.translatesAutoresizingMaskIntoConstraints = false
        changePasswordActionLabel.isUserInteractionEnabled = true
        changePasswordActionLabel.text = "Изменить пароль"
        changePasswordActionLabel.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        changePasswordActionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: UIScreen.main.bounds.height * 0.018)

        return changePasswordActionLabel
    }()

    // Надпись "Изменить адрес электронной почты"
    let changeEmailActionLabel: UIGradientLabel = {
        let changeEmailActionLabel = UIGradientLabel()
        changeEmailActionLabel.translatesAutoresizingMaskIntoConstraints = false
        changeEmailActionLabel.isUserInteractionEnabled = true
        changeEmailActionLabel.text = "Изменить адрес электронной почты"
        changeEmailActionLabel.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        changeEmailActionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: UIScreen.main.bounds.height * 0.018)

        return changeEmailActionLabel
    }()

    // Надпись "Выйти из учетной записи"
    let toAuthenticationActionLabel: UIGradientLabel = {
        let toAuthenticationActionLabel = UIGradientLabel()
        toAuthenticationActionLabel.translatesAutoresizingMaskIntoConstraints = false
        toAuthenticationActionLabel.isUserInteractionEnabled = true
        toAuthenticationActionLabel.text = "Выйти из учетной записи"
        toAuthenticationActionLabel.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        toAuthenticationActionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: UIScreen.main.bounds.height * 0.018)

        return toAuthenticationActionLabel
    }()

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(background)
        backgroundConstraints()

        addSubview(title)
        titleConstraints()

        addSubview(settingsStackView)
        settingsStackViewConstraints()

        settingsStackView.addArrangedSubview(distanceTitle)
        settingsStackView.addArrangedSubview(distanceSegmentedControl)
        settingsStackView.addArrangedSubview(updateLocationActionLabel)
        settingsStackView.addArrangedSubview(changePasswordActionLabel)
        settingsStackView.addArrangedSubview(changeEmailActionLabel)
        settingsStackView.addArrangedSubview(toAuthenticationActionLabel)

        addSubview(gradientLogo)
        gradientLogoConstraints()
    }

    override required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
}

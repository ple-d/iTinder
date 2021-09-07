import UIKit

class MatchView: UIView {

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

    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Поиск человечка"
        title.textAlignment = .center
        title.textColor = appColor.black
        title.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)

        return title
    }()

    func titleConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height / 16),
            title.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    let cardContainer: UIView = {
        let cardContainer = UIView()
        cardContainer.translatesAutoresizingMaskIntoConstraints = false

        return cardContainer
    }()

    func cardContainerConstraints() {
        NSLayoutConstraint.activate([
            cardContainer.topAnchor.constraint(equalTo: title.topAnchor, constant: UIScreen.main.bounds.height / 16),
            cardContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            cardContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
    }

    let biographyLabel: UILabel = {
        let biograpyLabel = UILabel()
        biograpyLabel.translatesAutoresizingMaskIntoConstraints = false
        biograpyLabel.numberOfLines = 0
        biograpyLabel.lineBreakMode = .byWordWrapping
        biograpyLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        biograpyLabel.textColor = appColor.black

        return biograpyLabel
    }()

    func biographyLabelConstraints() {
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: UIScreen.main.bounds.height / 100),
            biographyLabel.leftAnchor.constraint(equalTo: cardContainer.leftAnchor, constant: 10),
            biographyLabel.rightAnchor.constraint(equalTo: cardContainer.rightAnchor, constant: -10)
        ])
    }

    let locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.numberOfLines = 0
        locationLabel.lineBreakMode = .byWordWrapping
        locationLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        locationLabel.textColor = appColor.black

        return locationLabel
    }()

    func locationLabelConstraints() {
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: UIScreen.main.bounds.height / 100),
            locationLabel.leftAnchor.constraint(equalTo: cardContainer.leftAnchor, constant: 10),
            locationLabel.rightAnchor.constraint(equalTo: cardContainer.rightAnchor, constant: -10)
        ])
    }

    let dismissButton: UIImageView = {
        let dismissButton = UIImageView()
        dismissButton.isUserInteractionEnabled = true
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.image = UIImage(named: "dismiss")
        dismissButton.contentMode = .scaleAspectFill
        dismissButton.isHidden = true

        return dismissButton
    }()

    func dismissButtonConstraints() {
        NSLayoutConstraint.activate([
            dismissButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            dismissButton.rightAnchor.constraint(equalTo: centerXAnchor, constant: -40),
            dismissButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.10),
            dismissButton.heightAnchor.constraint(equalTo: dismissButton.widthAnchor)
        ])
    }

    let likeButton: UIImageView = {
        let likeButton = UIImageView()
        likeButton.isUserInteractionEnabled = true
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.image = UIImage(named: "like")
        likeButton.contentMode = .scaleAspectFill
        likeButton.isHidden = true
        likeButton.layer.zPosition = 5
        return likeButton
    }()

    func likeButtonConstraints() {
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            likeButton.leftAnchor.constraint(equalTo: centerXAnchor, constant: 40),
            likeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.10),
            likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor)
        ])
    }

    let noCardStackView: UIStackView = {
        let noCardStackView = UIStackView()
        noCardStackView.translatesAutoresizingMaskIntoConstraints = false
        noCardStackView.axis = .vertical
        noCardStackView.alignment = .center
        noCardStackView.spacing = UIScreen.main.bounds.height * 0.025

        return noCardStackView
    }()

    func noCardStackViewConstraints() {
        NSLayoutConstraint.activate([
            noCardStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noCardStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    let emptyImageView: UIImageView = {
        let emptyImageView = UIImageView()
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyImageView.image = UIImage(named: "empty")
        emptyImageView.contentMode = .scaleAspectFill

        return emptyImageView
    }()

    func emptyImageViewConstraints() {
        NSLayoutConstraint.activate([
            emptyImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            emptyImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }

    let anewButton: UIGradientButton = {
        let anewButton = UIGradientButton()
        anewButton.translatesAutoresizingMaskIntoConstraints = false
        anewButton.clipsToBounds = true
        anewButton.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        anewButton.setTitleColor(.white, for: .normal)
        anewButton.setTitle("Заново", for: .normal)
        anewButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return anewButton
    }()

    func anewButtonConstraints() {
        NSLayoutConstraint.activate([
            anewButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            anewButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
        ])
    }

    // Надпись "Зарегистрируйся!"
    let toSettingsActionLabel: UIGradientLabel = {
        let toSettingsActionLabel = UIGradientLabel()
        toSettingsActionLabel.translatesAutoresizingMaskIntoConstraints = false
        toSettingsActionLabel.isUserInteractionEnabled = true
        toSettingsActionLabel.text = "Изменить настройки"
        toSettingsActionLabel.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        toSettingsActionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: UIScreen.main.bounds.height * 0.018)

        return toSettingsActionLabel
    }()

    // Поп-ап это мэтч
    let itsMatchView: UIView = {
        let itsMatchView = UIView()
        itsMatchView.translatesAutoresizingMaskIntoConstraints = false
        itsMatchView.layer.cornerRadius = 15
        itsMatchView.layer.masksToBounds = true
        itsMatchView.isHidden = true
        itsMatchView.alpha = 0
        itsMatchView.layer.zPosition = 11
        itsMatchView.backgroundColor = .white

        return itsMatchView
    }()

    func itsMatchViewConstraints() {
        NSLayoutConstraint.activate([
            itsMatchView.centerXAnchor.constraint(equalTo: centerXAnchor),
            itsMatchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            itsMatchView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
    }

    // Заголовок "Вот это совпадение"
    let itsMatchTitle: UILabel = {
        let itsMatchTitle = UILabel()
        itsMatchTitle.translatesAutoresizingMaskIntoConstraints = false
        itsMatchTitle.text = "Вот это совпадение!"
        itsMatchTitle.textAlignment = .center
        itsMatchTitle.numberOfLines = 0
        itsMatchTitle.lineBreakMode = .byWordWrapping
        itsMatchTitle.textColor = appColor.black
        itsMatchTitle.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)

        return itsMatchTitle
    }()

    func itsMatchTitleConstraints() {
        NSLayoutConstraint.activate([
            itsMatchTitle.topAnchor.constraint(equalTo: itsMatchView.topAnchor, constant: UIScreen.main.bounds.height / 32),
            itsMatchTitle.rightAnchor.constraint(equalTo: itsMatchView.rightAnchor, constant: -UIScreen.main.bounds.height / 24),
            itsMatchTitle.leftAnchor.constraint(equalTo: itsMatchView.leftAnchor, constant: UIScreen.main.bounds.height / 24),
            itsMatchTitle.centerXAnchor.constraint(equalTo: itsMatchView.centerXAnchor)
        ])
    }

    // Кнопка "Войти"
    let toChatButton: UIGradientButton = {
        let toChatButton = UIGradientButton()
        toChatButton.translatesAutoresizingMaskIntoConstraints = false
        toChatButton.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        toChatButton.setTitleColor(.white, for: .normal)
        toChatButton.setTitle("Связаться", for: .normal)
        toChatButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return toChatButton
    }()

    func toChatButtonConstraints() {
        NSLayoutConstraint.activate([
            toChatButton.topAnchor.constraint(equalTo: itsMatchTitle.bottomAnchor, constant: UIScreen.main.bounds.height / 32),
            toChatButton.centerXAnchor.constraint(equalTo: itsMatchTitle.centerXAnchor),
            toChatButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            toChatButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17)
        ])
    }

    // Заголовок "Вот это совпадение"
    let continueLabel: UILabel = {
        let continueLabel = UILabel()
        continueLabel.translatesAutoresizingMaskIntoConstraints = false
        continueLabel.text = "Продолжить поиск"
        continueLabel.textAlignment = .center
        continueLabel.textColor = appColor.gray
        continueLabel.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.025)
        continueLabel.isUserInteractionEnabled = true

        return continueLabel
    }()

    func continueLabelConstraints() {
        NSLayoutConstraint.activate([
            continueLabel.topAnchor.constraint(equalTo: toChatButton.bottomAnchor, constant: UIScreen.main.bounds.height / 32),
            continueLabel.centerXAnchor.constraint(equalTo: itsMatchTitle.centerXAnchor),
            continueLabel.leftAnchor.constraint(equalTo: itsMatchView.leftAnchor),
            continueLabel.rightAnchor.constraint(equalTo: itsMatchView.rightAnchor),
            continueLabel.bottomAnchor.constraint(equalTo: itsMatchView.bottomAnchor, constant: -UIScreen.main.bounds.height / 24)
        ])
    }

    //Размытие
    let blur: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let visualEffect = UIVisualEffectView(effect: blur)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.isHidden = true
        visualEffect.alpha = 0
        visualEffect.layer.zPosition = 10

        return visualEffect
    }()

    func blurConstraints() {
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: topAnchor),
            blur.rightAnchor.constraint(equalTo: rightAnchor),
            blur.bottomAnchor.constraint(equalTo: bottomAnchor),
            blur.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(background)
        backgroundConstraints()

        addSubview(title)
        titleConstraints()

        addSubview(cardContainer)
        cardContainerConstraints()
        cardContainer.layer.zPosition = 2

        addSubview(noCardStackView)
        noCardStackViewConstraints()

        noCardStackView.addArrangedSubview(emptyImageView)
        emptyImageViewConstraints()
        noCardStackView.setCustomSpacing(UIScreen.main.bounds.height * 0.05, after: emptyImageView)

        noCardStackView.addArrangedSubview(anewButton)
        anewButtonConstraints()

        noCardStackView.addArrangedSubview(toSettingsActionLabel)

        addSubview(dismissButton)
        dismissButtonConstraints()

        addSubview(likeButton)
        likeButtonConstraints()

        addSubview(locationLabel)
        locationLabelConstraints()

        addSubview(biographyLabel)
        biographyLabelConstraints()

        addSubview(blur)
        blurConstraints()

        addSubview(itsMatchView)
        itsMatchViewConstraints()

        itsMatchView.addSubview(itsMatchTitle)
        itsMatchTitleConstraints()

        itsMatchView.addSubview(toChatButton)
        toChatButtonConstraints()

        itsMatchView.addSubview(continueLabel)
        continueLabelConstraints()

        locationLabel.font = UIFont(name: "HelveticaNeue-Bold", size: bounds.height * 0.022)
        biographyLabel.font = UIFont(name: "HelveticaNeue-Medium", size: bounds.height * 0.02)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()

        locationLabel.font = UIFont(name: "HelveticaNeue-Bold", size: bounds.height * 0.022)
        biographyLabel.font = UIFont(name: "HelveticaNeue-Medium", size: bounds.height * 0.02)

        anewButton.layer.cornerRadius = anewButton.bounds.height / 2
    }
}

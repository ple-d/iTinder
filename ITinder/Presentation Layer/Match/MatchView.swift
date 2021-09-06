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
        biograpyLabel.text = ""
        biograpyLabel.textColor = appColor.black
        
        return biograpyLabel
    }()

    func biographyLabelConstraints() {
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: UIScreen.main.bounds.height / 100),
            biographyLabel.leftAnchor.constraint(equalTo: cardContainer.leftAnchor, constant: 10),
            biographyLabel.rightAnchor.constraint(equalTo: cardContainer.rightAnchor, constant: -10)
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

        addSubview(biographyLabel)
        biographyLabelConstraints()
    }

    override required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()

        biographyLabel.font = UIFont(name: "HelveticaNeue-Medium", size: bounds.height * 0.02)
        anewButton.layer.cornerRadius = anewButton.bounds.height / 2
    }
}

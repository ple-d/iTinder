import UIKit

class ProfileView: UIView {

    // Заголовок "Немного о себе"
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Всё о вас"
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

    let card: CardView = {
        let card = CardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.user = User.currentUser
        return card
    }()

    func cardConstraints() {
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: title.topAnchor, constant: UIScreen.main.bounds.height / 12),
            card.centerXAnchor.constraint(equalTo: centerXAnchor),
            card.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            card.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
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
            biographyLabel.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: UIScreen.main.bounds.height / 100),
            biographyLabel.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 10),
            biographyLabel.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -10)
        ])
    }

    let editButton: UIImageView = {
        let editButton = UIImageView()
        editButton.isUserInteractionEnabled = true
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.image = UIImage(named: "editProfileIcon")
        return editButton
    }()

    func editButtonConstraints() {
        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: card.bottomAnchor),
            editButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06),
            editButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06),
            editButton.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -UIScreen.main.bounds.width / 10)
        ])
    }

    let settingsButton: UIImageView = {
        let settingsButton = UIImageView()
        settingsButton.isUserInteractionEnabled = true
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.image = UIImage(named: "settingsIcon")

        return settingsButton
    }()

    func settingsButtonConstraints() {
        NSLayoutConstraint.activate([
            settingsButton.centerYAnchor.constraint(equalTo: card.bottomAnchor),
            settingsButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06),
            settingsButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06),
            settingsButton.rightAnchor.constraint(equalTo: editButton.leftAnchor, constant: -UIScreen.main.bounds.width / 20)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(background)
        backgroundConstraints()

        addSubview(title)
        titleConstraints()
        
        addSubview(card)
        cardConstraints()

        addSubview(editButton)
        editButtonConstraints()

        addSubview(settingsButton)
        settingsButtonConstraints()

        addSubview(biographyLabel)
        biographyLabelConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()

        editButton.layer.cornerRadius = editButton.bounds.height / 2
        settingsButton.layer.cornerRadius = settingsButton.bounds.height / 2

        biographyLabel.font = UIFont(name: "HelveticaNeue-Medium", size: bounds.height * 0.02)
    }
}

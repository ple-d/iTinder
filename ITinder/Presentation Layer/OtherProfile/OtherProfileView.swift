import UIKit

class OtherProfileView: UIView {

    // Заголовок "Немного о себе"
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Знакомьтесь"
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
        biograpyLabel.textColor = Color.black

        return biograpyLabel
    }()

    func biographyLabelConstraints() {
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: chatButton.bottomAnchor, constant: UIScreen.main.bounds.height / 100),
            biographyLabel.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 10),
            biographyLabel.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -10)
        ])
    }

    let chatButton: UIImageView = {
        let chatButton = UIImageView()
        chatButton.isUserInteractionEnabled = true
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        chatButton.image = UIImage(named: "toConversationIcon")
        return chatButton
    }()

    func chatButtonConstraints() {
        NSLayoutConstraint.activate([
            chatButton.centerYAnchor.constraint(equalTo: card.bottomAnchor),
            chatButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06),
            chatButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06),
            chatButton.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -UIScreen.main.bounds.width / 10)
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

        addSubview(chatButton)
        chatButtonConstraints()

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
    }
}

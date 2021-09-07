import UIKit

class MatchPopUpView: UIView {
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Вот это совпадение!"
        titleLabel.textAlignment = .center
        titleLabel.textColor = appColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)

        return titleLabel
    }()

    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height / 80),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabelConstraints()

        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        self.layer.cornerRadius = bounds.height / 16
    }
}

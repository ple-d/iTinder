import UIKit

class UIWarningView: UIView {

    var warningViewTopConstraint = NSLayoutConstraint()
    var warningViewTopOffset = CGFloat(0)

    // Вычисляемое свойство, позволяющее установить или получить текущий заголовок
    var title: String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }

    // Вычисляемое свойство, позволяющее установить или получить текущий текст
    var text: String {
        get {
            return textLabel.text ?? ""
        }
        set {
            textLabel.text = newValue
        }
    }

    // Заголовок
    private let titleLabel: UIGradientLabel = {
        let titleLabel = UIGradientLabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.020)

        return titleLabel
    }()

    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: UIScreen.main.bounds.height * 0.018),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -UIScreen.main.bounds.height * 0.018),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.018)
        ])
    }

    // Текст
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = appColor.black
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping

        textLabel.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.020)

        return textLabel
    }()

    private func textLabelConstraints() {
        NSLayoutConstraint.activate([
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: UIScreen.main.bounds.height * 0.018),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.009),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -UIScreen.main.bounds.height * 0.018),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height * 0.018)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabelConstraints()

        addSubview(textLabel)
        textLabelConstraints()
        
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        self.layer.cornerRadius = bounds.height / 4

        warningViewTopOffset = bounds.height + UIScreen.main.bounds.height / 32
    }

    // Метод, который задает размеры внутри superview
    func setup() {
        guard let superview = superview else {
            return
        }

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.9),

        ])

        warningViewTopConstraint = topAnchor.constraint(equalTo: superview.bottomAnchor)
        warningViewTopConstraint.isActive = true
    }

    // Метод ответственный за показ
    func show(title: String, text: String) {
        guard let superview = superview else {
            return
        }
        if warningViewTopConstraint.constant ?? 0 != 0 {
            hide {
                self.title = title
                self.text = text
                self.layoutSubviews()

                UIView.animate(withDuration: 0.3) {
                    self.warningViewTopConstraint.constant = -(self.warningViewTopOffset ?? 0)
                    superview.layoutIfNeeded()
                }
            }
        } else {
            self.title = title
            self.text = text
            self.layoutSubviews()

            UIView.animate(withDuration: 0.3) {
                self.warningViewTopConstraint.constant = -(self.warningViewTopOffset ?? 0)
                superview.layoutIfNeeded()
            }
        }
    }

    // Метод ответственный за скрытие
    func hide(completion: @escaping () -> ())  {
        guard let superview = superview else {
            return
        }

        UIView.animate(withDuration: 0.3, animations: {
            self.warningViewTopConstraint.constant = 0
            superview.layoutIfNeeded()
        }, completion: { bool in
            completion()
        })
    }
}

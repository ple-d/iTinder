import UIKit

class UIGradientTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // UIView для корректного отображения тени
    let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.backgroundColor = .white
        shadowView.layer.zPosition = -1
        shadowView.isUserInteractionEnabled = false
        return shadowView
    }()

    func shadowViewConstraints() {
        NSLayoutConstraint.activate([
            shadowView.heightAnchor.constraint(equalTo: heightAnchor),
            shadowView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    let placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()

        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.textAlignment = .center
        placeholderLabel.textColor = Color.gray
        placeholderLabel.font = UIFont(name: "HelveticaNeue-Medium", size: UIScreen.main.bounds.height * 0.017)
        placeholderLabel.backgroundColor = .white

        return placeholderLabel
    }()

    func placeholderLabelConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.centerYAnchor.constraint(equalTo: topAnchor),
            placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: UIScreen.main.bounds.width * 0.7 * 0.1)
        ])
    }

    // Вычисляемое свойство, позволяющее установить или получить текущие цвета градиента
    var gradientColors: [CGColor] {
        get {
            return gradientLayer.colors as! [CGColor]
        }
        set {
            gradientLayer.colors = newValue
        }
    }

    // Градиентный слой
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor]

        return gradient
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.masksToBounds = false
        layer.addSublayer(gradientLayer)

        addSubview(shadowView)
        shadowViewConstraints()

        addSubview(placeholderLabel)
        placeholderLabelConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    fileprivate func addShadow() {
        shadowView.layer.cornerRadius = layer.cornerRadius
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        shadowView.layer.shadowOpacity = 0.15
        shadowView.layer.shadowRadius = 2.0
    }

    fileprivate func addGradientLayer() {
        gradientLayer.frame =  CGRect(origin: .zero, size: bounds.size)
        let shape = CAShapeLayer()
        shape.lineWidth = 5
        shape.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradientLayer.mask = shape
        gradientLayer.cornerRadius = layer.cornerRadius
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        addGradientLayer()
        addShadow()
    }
}

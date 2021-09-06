import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true



        return imageView
    }()

    func imageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }

    let plusLabel: UIGradientLabel = {
        let plusLabel = UIGradientLabel()
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        plusLabel.text = "+"
        plusLabel.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        plusLabel.font = UIFont(name: "Helvetica", size: UIScreen.main.bounds.height * 0.035)
        plusLabel.isHidden = true

        return plusLabel
    }()

    func plusLabelConstraints() {
        NSLayoutConstraint.activate([
            plusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            plusLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    let deleteButton: UIImageView = {
        let deleteButton = UIImageView()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.isUserInteractionEnabled = true
        deleteButton.image = UIImage(named: "deleteIcon")

        return deleteButton
    }()

    func deleteButtonConstraints() {
        NSLayoutConstraint.activate([
            deleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -2),
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            deleteButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor)
        ])
    }


    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .white

        contentView.addSubview(imageView)
        imageViewConstraints()

        contentView.addSubview(plusLabel)
        plusLabelConstraints()

        contentView.addSubview(deleteButton)
        deleteButtonConstraints()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        superview?.layoutSubviews()

        imageView.layer.cornerRadius = imageView.bounds.height / 16
        layer.cornerRadius = contentView.bounds.height / 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.bounds.height / 16).cgPath
        layer.shadowOffset = CGSize(width: 0.0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2.0

    }

    func setAsAddButton() {
        imageView.image = nil
        plusLabel.isHidden = false
        imageView.isHidden = true
        deleteButton.isHidden = true
        layoutIfNeeded()
    }

    func setImageData(imageData: Data){
        imageView.image = UIImage(data: imageData)
        plusLabel.isHidden = true
        imageView.isHidden = false
        deleteButton.isHidden = false
        layoutIfNeeded()
    }
}

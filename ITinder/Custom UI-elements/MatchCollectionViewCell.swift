import UIKit

class MatchCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "Match Cell"

    // Фотография пользователя
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        return imageView
    }()

    func imageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }

    // Имя пользователя
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Дмитрий"
        nameLabel.textAlignment = .center
        nameLabel.textColor = Color.black


        return nameLabel
    }()

    func nameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }


    override init(frame: CGRect){
        super.init(frame: frame)

        addSubview(imageView)
        imageViewConstraints()

        addSubview(nameLabel)
        nameLabelConstraints()

        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        superview?.layoutSubviews()
        layoutIfNeeded()
        
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: contentView.bounds.height * 0.15)

    }

    func setEmptyImage() {
        imageView.image = UIImage(named: "noMatches")
        nameLabel.isHidden = true
    }
}

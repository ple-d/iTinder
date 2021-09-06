import UIKit

class CardPhotoCollectionViewCell: UICollectionViewCell {
    let photo: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.translatesAutoresizingMaskIntoConstraints = false

        return photo
    }()

    func photoConstraints() {
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photo.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(photo)
        photoConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        superview?.layoutSubviews()
    }
}

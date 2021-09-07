import UIKit

protocol ProfileViewProtocol: AnyObject {
    func setImageForCell(index: Int, imageData: Data)
    func reloadPhotoCollection()
    func setUserInformation(name: String, age: String, gender: String, position: String, englishLevel: String, biography: String, country: String, city: String)
    func updateCard()
}

class ProfileController: UIViewController, ProfileViewProtocol {
    func updateCard() {
        let view = view as? ProfileView
        view?.card.update()
    }

    var presenter: ProfilePresenterProtocol?

    override func loadView() {
        view = ProfileView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = view as? ProfileView

        let toEditProfileTap = UITapGestureRecognizer(target: self, action: #selector(toEditProfile))
        view?.editButton.addGestureRecognizer(toEditProfileTap)

        let toSettingsTap = UITapGestureRecognizer(target: self, action: #selector(toSettings))
        view?.settingsButton.addGestureRecognizer(toSettingsTap)

    }

    @objc func toEditProfile() {
        presenter?.toEditProfile()
    }

    @objc func toSettings() {
        presenter?.toSettings()
    }


    func setUserInformation(name: String, age: String, gender: String, position: String, englishLevel: String, biography: String, country: String, city: String) {
        let view = view as? ProfileView
        view?.card.nameAndAgeLabel.text = "\(name), \(age)"
        view?.card.genderLabel.text = gender
        view?.card.positionLabel.text = "👨‍💻 \(position)"
        view?.card.englishLevelLabel.text = "🇬🇧 \(englishLevel)"
        view?.biographyLabel.text = biography
        view?.locationLabel.text = "📍\(country), \(city)"
    }

    // Установка изображения для ячейки photoCollection
    func setImageForCell(index: Int, imageData: Data) {
        let view = view as? ProfileView
        guard let cell = view?.card.photoCollection.cellForItem(at: IndexPath(item: index, section: 0)) as? CardPhotoCollectionViewCell else {
            return
        }

        cell.photo.image = UIImage(data: imageData)
        view?.layoutSubviews()
        view?.layoutIfNeeded()
    }

    // Обновление данных в photoCollection
    func reloadPhotoCollection() {
        let view = view as? ProfileView
        DispatchQueue.main.async{
            view?.card.photoCollection.reloadData()
            view?.card.photoCollection.collectionViewLayout.invalidateLayout()
            if let indexPaths = view?.card.photoCollection.indexPathsForVisibleItems {
                view?.card.photoCollection.reloadItems(at: indexPaths)
            }
            view?.layoutIfNeeded()
        }

    }
}

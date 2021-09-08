import UIKit

protocol OtherProfileViewProtocol: AnyObject {
    func setImageForCell(index: Int, imageData: Data)
    func reloadPhotoCollection()
    func setUser(user: User)
    func updateCard()
}

class OtherProfileController: UIViewController, OtherProfileViewProtocol {
    func updateCard() {
        let view = view as? OtherProfileView
        view?.card.update()
    }

    var presenter: OtherProfilePresenterProtocol?

    override func loadView() {
        view = OtherProfileView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = view as? OtherProfileView

        let toConversationTap = UITapGestureRecognizer(target: self, action: #selector(toConversation))
        view?.chatButton.addGestureRecognizer(toConversationTap)

    }

    @objc func toConversation() {
        presenter?.toConversation()
    }


    func setUser(user: User) {
        let view = view as? OtherProfileView
        view?.card.user = user
        view?.biographyLabel.text = user.biography
        view?.locationLabel.text = "📍 \(user.country ?? "Нет страны"), \(user.city ?? "Нет города")"
    }

    // Установка изображения для ячейки photoCollection
    func setImageForCell(index: Int, imageData: Data) {
        let view = view as? OtherProfileView
        guard let cell = view?.card.photoCollection.cellForItem(at: IndexPath(item: index, section: 0)) as? CardPhotoCollectionViewCell else {
            return
        }

        cell.photo.image = UIImage(data: imageData)
        view?.layoutSubviews()
        view?.layoutIfNeeded()
    }

    // Обновление данных в photoCollection
    func reloadPhotoCollection() {
        let view = view as? OtherProfileView
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

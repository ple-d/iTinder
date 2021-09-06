import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    func getImageData()
    func getCountOfUserImages() -> Int
    func toEditProfile()
    func toSettings()
}

class ProfilePresenter: ProfilePresenterProtocol {

    weak var view: ProfileViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()

    var biographyObserver: NSKeyValueObservation?

    func getImageData() {
        guard let imagePaths = User.currentUser?.imagePaths else {
            return
        }

        firebaseManager.loadUserImages(imagePaths: User.currentUser?.imagePaths ?? []) { imagePath, imageData, error in
            guard let imageData = imageData, error == nil else {
                return
            }

            User.currentUser?.imageDictionary[imagePath] = imageData
            self.view?.updateCard()
           
        }
    }

    init(view: ProfileViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter

        if let currentUser = User.currentUser {
            let gender = currentUser.isMale ?? true ? "мужской" : "женский"
            view.setUserInformation(name: currentUser.name ?? "", age: String(currentUser.age), gender: gender, position: currentUser.position ?? "", englishLevel: currentUser.englishLevel ?? "", biography: currentUser.biography ?? "")
        }

        biographyObserver = User.currentUser!.observe(\.biography) { _, _ in
            if let currentUser = User.currentUser {
                let gender = currentUser.isMale ?? true ? "мужской" : "женский"
                view.setUserInformation(name: currentUser.name ?? "", age: String(currentUser.age), gender: gender, position: currentUser.position ?? "", englishLevel: currentUser.englishLevel ?? "", biography: currentUser.biography ?? "")
            }
        }

        getImageData()

    }

    func toEditProfile() {
        moduleRouter.toEditProfile()
    }

    func toSettings() {
        moduleRouter.toSettings()
    }

    // Метод возвращающий количество изображений у пользователя
    func getCountOfUserImages() -> Int {
        return User.currentUser?.imagePaths.count ?? 0
    }
}

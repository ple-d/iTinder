import UIKit

protocol OtherProfilePresenterProtocol: AnyObject {
    func getImageData()
    func getCountOfUserImages() -> Int
    func toConversation()
}

class OtherProfilePresenter: OtherProfilePresenterProtocol {
    func toConversation() {
        
    }


    weak var view: OtherProfileViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()
    private let user: User

    func getImageData() {

        firebaseManager.loadUserImages(imagePaths: user.imagePaths) { imagePath, imageData, error in
            guard let imageData = imageData, error == nil else {
                return
            }

            self.user.imageDictionary[imagePath] = imageData
            self.view?.updateCard()

        }
    }

    init(view: OtherProfileViewProtocol, moduleRouter: ModuleRouterProtocol, user: User) {
        self.view = view
        self.moduleRouter = moduleRouter
        self.user = user
        
        view.setUser(user: user)
        
        getImageData()
    }

    // Метод возвращающий количество изображений у пользователя
    func getCountOfUserImages() -> Int {
        return User.currentUser?.imagePaths.count ?? 0
    }
}

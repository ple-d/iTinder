import UIKit

protocol OtherProfilePresenterProtocol: AnyObject {
    func getCountOfUserImages() -> Int
    func toConversation()
}

class OtherProfilePresenter: OtherProfilePresenterProtocol {
    func toConversation() {
        
    }

    weak var view: OtherProfileViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()
    private let id: String
    private var user: User? = nil

    init(view: OtherProfileViewProtocol, moduleRouter: ModuleRouterProtocol, id: String) {
        self.view = view
        self.moduleRouter = moduleRouter
        self.id = id


        firebaseManager.getUserDataFromFirestore(id: id) { user, error in
            guard let user = user, error == nil else {
                return
            }

            view.setUser(user: user)
            self.user = user
            self.firebaseManager.loadUserImages(imagePaths: user.imagePaths) { imagePath, imageData, error in
                guard let imageData = imageData, error == nil else {
                    return
                }

                user.imageDictionary[imagePath] = imageData
            }
        }
    }

    // Метод возвращающий количество изображений у пользователя
    func getCountOfUserImages() -> Int {
        return User.currentUser?.imagePaths.count ?? 0
    }
}

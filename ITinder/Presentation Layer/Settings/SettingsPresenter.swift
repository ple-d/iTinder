import UIKit

protocol SettingsPresenterProtocol: AnyObject {
    func toAuthentication()
    func toChangePassword()
    func newUserLocation(country: String, city: String, longitude: Double, latitude: Double)
}

class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()

    init(view: SettingsViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter
    }

    func toAuthentication() {
        firebaseManager.signOut { error in
            guard error == nil else {
                return
            }

            moduleRouter.dissmiss()
            moduleRouter.popToRoot()
        }

    }

    func toChangePassword() {
        moduleRouter.dissmiss()
        moduleRouter.toChangePassword()
    }

    // Метод обновляющий геолокацию пользователя
    func newUserLocation(country: String, city: String, longitude: Double, latitude: Double) {
        firebaseManager.newUserLocation(userID: User.currentUser?.id ?? "", country: country, city: city, longitude: longitude, latitude: latitude) { error in
            User.currentUser?.country = country
            User.currentUser?.city = city
            User.currentUser?.longitude = longitude
            User.currentUser?.latitude = latitude
        }
    }

}

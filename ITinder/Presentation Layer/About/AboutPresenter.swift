import UIKit

protocol AboutPresenterProtocol: AnyObject {
    func getImageData(index: Int)
    func getCountOfUserImages() -> Int
    func loadImageData(data: Data)
    func removeImage(index: Int)
    func newUserLocation(country: String, city: String, longitude: Double, latitude: Double)
    func start(biography: String, birthday: Date, englishLevel: String, position: String)
    func toAuthentication()
}

class AboutPresenter: AboutPresenterProtocol {
    weak var view: AboutViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()

    init(view: AboutViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter

        getImageData(index: 1)
    }

    // Метод ответственный за получение изображения пользователя по его индексу
    func getImageData(index: Int) {
        firebaseManager.loadUserImages(imagePaths: User.currentUser?.imagePaths ?? []) { imagePath, imageData, error in
            guard let imageData = imageData, error == nil else {
                return
            }

            User.currentUser?.imageDictionary[imagePath] = imageData

            self.view?.reloadPhotoCollection()
        }
    }

    // Загрузка изображения пользователя
    func loadImageData(data: Data) {
        guard let userID = User.currentUser?.id else {
            return
        }

        firebaseManager.uploadUserImage(id: userID, imageData: data, imagePaths: User.currentUser?.imagePaths ?? []) { [weak self] imagePath, error in
            guard let imagePath = imagePath, error == nil else {
                return
            }

            User.currentUser?.imagePaths.append(imagePath)
            User.currentUser?.imageDictionary[imagePath] = data

            self?.view?.reloadPhotoCollection()
        }
    }

    func toAuthentication() {
        moduleRouter.popToRoot()
    }

    // Удаление изображения пользователя
    func removeImage(index: Int) {
        guard let user = User.currentUser  else {
            return
        }

        firebaseManager.removeUserImage(id: (user.id ?? ""), indexOfPath: index, imagePaths: (user.imagePaths ?? [])) { [weak self] error in
            guard error == nil else {
                return
            }

            let imagePath = user.imagePaths.remove(at: index)
            user.imageDictionary.removeValue(forKey: imagePath)
            
            self?.view?.reloadPhotoCollection()
        }
    }

    func start(biography: String, birthday: Date, englishLevel: String, position: String) {
        guard DataValidator.biographyIsValid(biography) else {
            view?.showWarning(title: "Ошибочка!", text: "Постарайся рассказать о себе в пределах от 40 до 160 символов.")
            return
        }

        guard !englishLevel.isEmpty else {
            view?.showWarning(title: "Ошибочка!", text: "Совсем не знаете английский язык? Да не может такого быть!")
            return
        }

        guard !position.isEmpty else {
            view?.showWarning(title: "Ошибочка!", text: "Кем работаешь? А может у тебя есть работа мечты?")
            return
        }

        guard let user = User.currentUser, let userID = user.id else {
            return
        }

        user.biography = biography
        user.birthday = birthday.timeIntervalSince1970
        user.englishLevel = englishLevel
        user.position = position
        user.registrationIsFinished = true

        firebaseManager.uploadDataInFirestore(data: user.dictionary, collection: "users", document: userID) { error in
            guard error == nil else {
                return
            }

            self.moduleRouter.toOnboarding()
        }
    }

    // Метод возвращающий количество изображений у пользователя
    func getCountOfUserImages() -> Int {
        return User.currentUser?.imagePaths.count ?? 0
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


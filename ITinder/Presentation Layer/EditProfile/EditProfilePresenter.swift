import UIKit

protocol EditProfilePresenterProtocol: AnyObject {
    func getImageData(index: Int)
    func getCountOfUserImages() -> Int
    func loadImageData(data: Data)
    func removeImage(index: Int)
    func update(biography: String, birthday: Date, englishLevel: String, position: String)
}

class EditProfilePresenter: EditProfilePresenterProtocol {
    weak var view: EditProfileViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()

    init(view: EditProfileViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter

        self.view?.setInformation(biography: User.currentUser?.biography ?? "", birthday: Date(timeIntervalSince1970: User.currentUser?.birthday ?? 0), englishLevel: User.currentUser?.englishLevel ?? "", position: User.currentUser?.position ?? "")

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

    func update(biography: String, birthday: Date, englishLevel: String, position: String) {
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

            self.moduleRouter.dissmiss()
        }
    }

    // Метод возвращающий количество изображений у пользователя
    func getCountOfUserImages() -> Int {
        return User.currentUser?.imagePaths.count ?? 0
    }
}


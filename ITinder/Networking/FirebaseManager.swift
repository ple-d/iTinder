// Добавить кнопку возврата к авторизации в About
// Сделать EditProfile полностью рабочим
// Протестировать окно профля, добавить страну и город на карточку
// Окно мэтчей - добавить картинку, добавить цветовую индикацию, корректное отображение биографии
// Настройки - Выход из профиля, обновление геопозиции, обновление пароля и почты
// Окно другого пользователя - похоже на окно текущего пользователя + иконка перехода к беседе
// Окно сообщений и мэтчей - горизонтальная коллекция мэтчей, если их 0, то показывать одну ячейку
// Корректное хранение даты рождения пользователя

// Посмотреть про обсерверы

import Firebase
import FirebaseFirestore

protocol DBManagerProtocol {

}

// Класс "Менеджер базы данных" содержит перечень методов для авторизации пользователей, загрузки, выгрузки данных из BaaS Firebase
class FirebaseManager: DBManagerProtocol {

    // Кэш для хранения изображений в Data
    let imageDataCache = NSCache<AnyObject, AnyObject>()

    private let storage =  Storage.storage()
    private let authentication = Auth.auth()
    private let firestore = Firestore.firestore()

    // Универсальный метод-обертка для загрузки Data в модуль Storage
    func uploadDataInStorage(data: Data, metadata: StorageMetadata?, path: String, completion: @escaping (_ error: String?) -> ()) {
        storage.reference(withPath: path).putData(data, metadata: metadata) { (metadata, error) in
            guard error == nil else {
                completion("Не удалось загрузить данные в модуль Storage")
                return
            }

            completion(nil)
        }
    }

    // Универсальный метод-обертка для выгрузки Data из модуля Storage
    func loadDataFromStorage(path: String, completion: @escaping (_ data: Data?, _ error: String?) -> ()) {
        storage.reference(withPath: path).getData(maxSize: 8 * 1024 * 1024) { data, error in
            guard let data = data, error == nil else {
                completion(nil,  "Не удалось получить данные из модуля Storage")
                return
            }

            completion(data, nil)
        }
    }

    // Универсальный метод-обертка для удаления Data из модуля Storage
    func removeDataFromStorage(path: String, completion: @escaping ( _ error: String?) -> ()) {
        storage.reference(withPath: path).delete { error in
            guard error == nil else {
                completion("Не удалить получить данные из модуля Storage")
                return
            }

            completion(nil)
        }
    }

    // Универсальный метод-обертка для загрузки [String: Any] в модуль Firestore
    func uploadDataInFirestore(data: [String : Any], collection: String, document: String, merge: Bool? = false, completion: @escaping (_ error: String?) -> ()) {
        firestore.collection(collection).document(document).setData(data, merge: merge ?? false){ error in
            guard error == nil else {
                completion("Неудалось загрузить данные в модуль Firestore")
                return
            }

            completion(nil)

        }
    }

    // Универсальный метод-обертка для выгрузки [String: Any] из модуля Firestore
    func loadDataFromFirestore(collection: String, document: String, completion: @escaping (_ data: [String : Any]?, _ error: String?) -> ()){
        firestore.collection(collection).document(document).getDocument{ document, error in
            guard let data = document?.data(), error == nil else {
                completion(nil, "Неудалось получить данные из модуля Firestore")
                return
            }

            completion(data, nil)
        }
    }

    // Метод ответственный за получение данных о пользователе из модуля Firestore
    func getUserDataFromFirestore(id: String, completion: @escaping (_ user: User?, _ error: String?) -> ()) {
        loadDataFromFirestore(collection: "users", document: id) { data, error in
            guard let userData = data, error == nil else {
                completion(nil, error)
                return
            }

            let user = User(dictionary: userData)
            completion(user, nil)
        }
    }

    // Метод ответственный за отправку письма для восстановления пароля
    func resetPassword(email: String, completion: @escaping ( _ error: String?) -> ()){
        authentication.sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                completion("Не удалось отправить письмо для восстановления пароля.")
                return
            }

            completion(nil)
        }
    }

    // Метод ответственный за авторизацию пользователя
    func signIn(email: String, password: String, completion: @escaping ( _ user: User?, _ error: String?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authenticationResult, error in
            guard let authenticatedUser = authenticationResult?.user, error == nil else {

                let errorCode = AuthErrorCode(rawValue: error!._code)

                switch errorCode {
                case .invalidEmail:
                    completion(nil, "Вы ввели неверный адрес электронной почты")
                case .wrongPassword:
                    completion(nil, "Вы ввели неверный пароль.")
                case .userNotFound:
                    completion(nil, "Вы уверены? Пользователь с такими данными не найден.")
                case .networkError:
                    completion(nil, "Сеть заболела. Неудалось войти в учетную запись.")
                default:
                    break
                }


                return
            }

            self?.getUserDataFromFirestore(id: authenticatedUser.uid) { user, error in
                guard let user = user, error == nil else {
                    completion(nil, error)
                    return
                }

                user.id = authenticatedUser.uid
                completion(user, nil)
            }
        }
    }

    // Метод ответственный за регистрацию пользователя (первый этап)
    func signUp(user: User, completion: @escaping (_ error: String?) -> ()) {
        authentication.createUser(withEmail: user.email ?? "" , password: user.password ?? "") { [weak self] registrationResult, error in
            guard let registredUser = registrationResult?.user, error == nil else {
                let errorCode = AuthErrorCode(rawValue: error!._code)

                switch errorCode {
                case .emailAlreadyInUse:
                    completion("Введенная электронная почта уже используется")
                case .networkError:
                    completion("Сеть заболела. Неудалось войти в учетную запись.")
                default:
                    break
                }

                return
            }

            user.id = registredUser.uid
            
            // Загрузка изображений пользователя
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            for imageData in user.imageDictionary.values {
                let imagePath = "users/\(registredUser.uid)/images/\(UUID().uuidString)"
                user.imagePaths.append(imagePath)
                self?.uploadDataInStorage(data: imageData, metadata: metadata, path: imagePath) { error in
                    guard error == nil else {
                        return
                    }
                }
            }

            self?.uploadDataInFirestore(data: user.dictionary, collection: "users", document: registredUser.uid, completion: completion)
        }
    }

    // Ме
    func loadUserImages(imagePaths: [String], completion: @escaping (_ path: String, _ data: Data?, _ error: String?) -> ()) {
        for imagePath in imagePaths {

            if let imageDataFromCache = imageDataCache.object(forKey: imagePath as AnyObject) as? Data {

                completion(imagePath, imageDataFromCache, nil)

                continue
            }

            loadDataFromStorage(path: imagePath) { imageData, error in
                guard let imageData = imageData, error == nil else {
                    completion(imagePath, nil, error)
                    return
                }
                self.imageDataCache.setObject(imageData as AnyObject, forKey: imagePath as AnyObject)
                completion(imagePath, imageData, nil)
            }
        }
    }

    // Метод для загрузки изображения пользователя в Firebase
    func uploadUserImage(id: String, imageData: Data, imagePaths: [String], completion: @escaping (_ imagePath: String?, _ error: String?) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        let imagePath = "users/\(id)/images/\(UUID().uuidString)"

        uploadDataInStorage(data: imageData, metadata: metadata, path: imagePath) { [weak self] error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            var userImagePaths = imagePaths
            userImagePaths.append(imagePath)

            self?.uploadDataInFirestore(data: ["imagePaths": userImagePaths], collection: "users", document: id, merge: true) { error in
                guard error == nil else{
                    completion(nil, error)
                    return
                }
                completion(imagePath, nil)
            }
        }
    }

    // Метод для удаления изображения пользователя из Firebase
    func removeUserImage(id: String, indexOfPath: Int, imagePaths: [String], completion: @escaping (_ error: String?) -> ()) {
        guard let imagePath = imagePaths[safe: indexOfPath] else {
            completion("Не удалось получить путь к картинке")
            return
        }
        removeDataFromStorage(path: imagePath) { [weak self] error in
            guard error == nil else {
                completion(error)
                return
            }

            var userImagePaths = imagePaths
            userImagePaths.remove(at: indexOfPath)

            self?.uploadDataInFirestore(data: ["imagePaths": userImagePaths], collection: "users", document: id, merge: true) { error in
                guard error == nil else{
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
    }

    // Выход из учетной записи пользователя
    func signOut(completion: (_ error: String?) -> ()) {
        do{
            try Auth.auth().signOut()
            completion(nil)
        } catch{
            completion("Неудалось выйти из учетной записи!")
        }
    }

    func changePassword(id: String, password: String, completion: @escaping (_ error: String?) -> ()) {
        Auth.auth().currentUser?.updatePassword(to: password) { [weak self] error in
            guard error == nil else {
                completion("Не удалось изменить пароль.")
                return
            }

            self?.uploadDataInFirestore(data: ["password": password], collection: "users", document: id, merge: true) { error in
                guard error == nil else {
                    completion("Не удалось изменить пароль.")
                    return
                }

                completion(nil)
            }

        }
    }

    // Метод ответственный за выборку пользователей для экрана "Поиск пар"
    func fetchUsersForMatch(excludedIDArray: [String], count: Int, completion: @escaping ( _ user: User?, _ error: String?) -> ()) {
        firestore.collection("users").whereField("registrationIsFinished", isEqualTo: true).whereField("id", notIn: excludedIDArray).getDocuments{ snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                return
            }
            snapshot.documents.forEach { document in
                let userDictionary = document.data()
                let user = User(dictionary: userDictionary)
                completion(user, nil)
            }
        }
    }

    // Метод ответственный за обновления массива лайков у пользователя
    func updateLikes(userID: String, likes: [String], completion: @escaping (_ error: String?) -> ()) {
        uploadDataInFirestore(data: ["likes": likes], collection: "users", document: userID, merge: true) { error in
            guard error == nil else{
                completion(error)
                return
            }
            completion(nil)
        }
    }

    // Метод ответственный за обновления массива дизлайков у пользователя
    func updateDislikes(userID: String, dislikes: [String], completion: @escaping (_ error: String?) -> ()) {
        uploadDataInFirestore(data: ["dislikes": dislikes], collection: "users", document: userID, merge: true) { error in
            guard error == nil else{
                completion(error)
                return
            }
            completion(nil)
        }
    }

    // Метод ответственный за сохранение нового совпадения в БД
    func newMatch(firstUserID: String, firstUserMatches: [String], secondUserID: String, secondUserMatches: [String], completion: @escaping (_ error: String?) -> ()) {
        uploadDataInFirestore(data: ["matches": firstUserMatches], collection: "users", document: firstUserID, merge: true) { error in
            guard error == nil else{
                completion(error)
                return
            }
            self.uploadDataInFirestore(data: ["matches": secondUserMatches], collection: "users", document: secondUserID, merge: true) { error in
                guard error == nil else{
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
    }

    // Метод ответственный за сохранение текущей геолокации пользователя (страна, город,)
    func newUserLocation(userID: String, country: String, city: String, longitude: Double, latitude: Double, completion: @escaping (_ error: String?) -> ()) {
        uploadDataInFirestore(data: ["country": country, "city": city, "longitude": longitude, "latitude": latitude], collection: "users", document: userID, merge: true) { error in
            guard error == nil else{
                completion(error)
                return
            }
            completion(nil)
        }
    }

    // Метод ответственный за выборку пользователей для экрана "Поиск пар"
    func fetchMatchedUsers(matches: [String], completion: @escaping ( _ user: User?, _ error: String?) -> ()) {
        guard !matches.isEmpty else {
            return
        }
        
        firestore.collection("users").whereField("id", in: matches).getDocuments { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                return
            }

            snapshot.documents.forEach { document in
                let userDictionary = document.data()
                let user = User(dictionary: userDictionary)
                completion(user, nil)
            }
        }
    }

    







}

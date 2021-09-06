import UIKit
import CoreLocation

protocol MatchPresenterProtocol: AnyObject {
    func getImageData()
    func getCountOfUserImages() -> Int
    func newLike(id: String)
    func newDislike(id: String)
    func newMatch(id: String, matches: [String])
    func loadUsers(count: Int)
    func toSettings()
    func anew()
}

class MatchPresenter: MatchPresenterProtocol {

    weak var view: MatchViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()
    private var distanceCanceled = [String]()

    var observer: NSKeyValueObservation?

    init(view: MatchViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter

        loadUsers(count: 3)
        getImageData()

        observer = UserDefaults.standard.observe(\.distance, options: [.new]) { (defaults, change) in
            self.update()
        }
    }

    var users: [User] = []  {
        didSet {
            view?.noCardStackViewIsVisible(users.isEmpty)
            view?.setBiography(users.first?.biography ?? "")
        }
    }

    func getImageData() {
        guard let imagePaths = User.currentUser?.imagePaths else {
            return
        }

        firebaseManager.loadUserImages(imagePaths: User.currentUser?.imagePaths ?? []) { imagePath, imageData, error in
            guard let imageData = imageData, error == nil else {
                return
            }

            User.currentUser?.imageDictionary[imagePath] = imageData
            
        }
    }

    // Метод ответсвенный за возобновление поиска пар
    func anew() {
        firebaseManager.updateDislikes(userID: User.currentUser?.id ?? "", dislikes: []) { [weak self] error in
            guard error == nil else {
                return
            }

            User.currentUser?.dislikes = []
            self?.loadUsers(count: 3)
        }
    }

    func update() {
        distanceCanceled.removeAll()
        users.removeAll()
        view?.update()
        loadUsers(count: 3)
    }

    func toSettings() {
        moduleRouter.toSettings()
    }

    func loadUsers(count: Int) {
        if !users.isEmpty {
            users.remove(at: 0)
        }


        let currentUserID = User.currentUser?.id ?? ""
        let userIDArray = users.map { user in
            return user.id ?? ""
        }
        let likes = User.currentUser?.likes ?? []
        let dislikes = User.currentUser?.dislikes ?? []

        firebaseManager.fetchUsersForMatch(excludedIDArray: [currentUserID] + userIDArray + likes + dislikes + distanceCanceled, count: count) { user, error in
            guard let user = user, error == nil else {
                return
            }

            if self.getDistance(latitude: user.latitude ?? 0, longitude: user.longitude ?? 0) > UserSettings.distance {
                self.distanceCanceled.append(user.id ?? "")
                self.loadUsers(count: 1)
                return
            }

            self.users.append(user)
            self.view?.newCard(user: user, distance: self.getDistance(latitude: user.latitude ?? 0, longitude: user.longitude ?? 0))

            
            self.firebaseManager.loadUserImages(imagePaths: user.imagePaths) { imagePath, imageData, error in
                guard let imageData = imageData, error == nil else {

                    return
                }


                user.imageDictionary[imagePath] = imageData
            }

        }
    }

    func getDistance(latitude: Double, longitude: Double) -> Int {
        let currentUserLocation = CLLocation(latitude: User.currentUser?.latitude ?? 0, longitude: User.currentUser?.latitude ?? 0)
        let otherUserLocation = CLLocation(latitude: latitude, longitude: longitude)

        return Int(currentUserLocation.distance(from: otherUserLocation) / 1000)
    }

    func newLike(id: String) {
        User.currentUser?.likes.append(id)
        firebaseManager.updateLikes(userID: User.currentUser?.id ?? "", likes: User.currentUser?.likes ?? []) { error in
            guard error == nil else {
                return
            }

        }
    }

    func newDislike(id: String) {
        User.currentUser?.dislikes.append(id)
        firebaseManager.updateDislikes(userID: User.currentUser?.id ?? "", dislikes: User.currentUser?.dislikes ?? []) { error in
            guard error == nil else {
                return
            }

        }
    }

    func newMatch(id: String, matches: [String]) {
        var secondUserMatches = matches
        secondUserMatches.append(User.currentUser?.id ?? "")
        User.currentUser?.matches.append(id)
        firebaseManager.newMatch(firstUserID: User.currentUser?.id ?? "", firstUserMatches: User.currentUser?.matches ?? [], secondUserID: id, secondUserMatches: secondUserMatches) { error in
            guard error == nil else {
                return
            }

        }
    }

    deinit {
        observer?.invalidate()
    }

    // Метод возвращающий количество изображений у пользователя
    func getCountOfUserImages() -> Int {
        return User.currentUser?.imagePaths.count ?? 0
    }
}

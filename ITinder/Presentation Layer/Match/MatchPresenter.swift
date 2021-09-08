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
    func toChat()
}

class MatchPresenter: MatchPresenterProtocol {

    weak var view: MatchViewProtocol?
    private var moduleRouter: ModuleRouterProtocol
    private let firebaseManager = FirebaseManager()
    private var distanceCanceled = [String]()

    private var lastLikedUserID: String?

    var distanceObserver: NSKeyValueObservation?

    init(view: MatchViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter

        loadUsers(count: 10)
        getImageData()

        distanceObserver = UserDefaults.standard.observe(\.distance, options: [.new]) { (defaults, change) in
            self.update()
        }
    }

    var users: [User] = []  {
        didSet {
            view?.noCardStackViewIsVisible(users.isEmpty)
            view?.setBiography(users.first?.biography ?? "")
            view?.setLocation(country: users.first?.country ?? "Нет страны", city: users.first?.city ?? "нет города")
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
            self?.loadUsers(count: 10)
        }
    }

    func update() {
        distanceCanceled.removeAll()
        users.removeAll()
        view?.update()
        loadUsers(count: 10)
    }

    func toSettings() {
        moduleRouter.toSettings()
    }

    func loadUsers(count: Int) {
        let currentUserID = User.currentUser?.id ?? ""
        let likes = User.currentUser?.likes ?? []
        let dislikes = User.currentUser?.dislikes ?? []

        firebaseManager.fetchUsersForMatch(excludedIDArray: [currentUserID], count: count) { user, error in
            guard let user = user, error == nil else {
                return
            }

            guard !likes.contains(user.id ?? "") else{
                return
            }

            guard !dislikes.contains(user.id ?? "") else{
                return
            }

            if  UserSettings.distance == 0 {
                print("Поиск по городу")
                guard user.city == User.currentUser!.city else {
                    return
                }
            } else {
                print("Поиск по дистанции")
                guard self.getDistance(latitude: user.latitude ?? 0, longitude: user.longitude ?? 0) < UserSettings.distance else{

                    return
                }
            }

            self.users.append(user)

            if self.users.count < 3 {
                self.view?.newCard(user: user, distance: self.getDistance(latitude: user.latitude ?? 0, longitude: user.longitude ?? 0))
            }


            self.firebaseManager.loadUserImages(imagePaths: user.imagePaths) { imagePath, imageData, error in
                guard let imageData = imageData, error == nil else {

                    return
                }

                user.imageDictionary[imagePath] = imageData
            }

        }
    }

    func getDistance(latitude: Double, longitude: Double) -> Int {
        let currentUserLocation = CLLocation(latitude: User.currentUser?.latitude ?? 0, longitude: User.currentUser?.longitude ?? 0)
        let otherUserLocation = CLLocation(latitude: latitude, longitude: longitude)

        return Int(currentUserLocation.distance(from: otherUserLocation) / 1000)
    }

    func newLike(id: String) {
        User.currentUser?.likes.append(id)
        firebaseManager.updateLikes(userID: User.currentUser?.id ?? "", likes: User.currentUser?.likes ?? []) { error in
            guard error == nil else {
                return
            }
            self.lastLikedUserID = self.users.first?.id

            if !self.users.isEmpty {
                self.users.remove(at: 0)
            }

            guard let user = self.users[safe: 1] else {
                return
            }

            self.view?.newCard(user: user, distance: self.getDistance(latitude: user.latitude ?? 0, longitude: user.longitude ?? 0))
        }
    }

    func newDislike(id: String) {
        User.currentUser?.dislikes.append(id)
        firebaseManager.updateDislikes(userID: User.currentUser?.id ?? "", dislikes: User.currentUser?.dislikes ?? []) { error in
            guard error == nil else {
                return
            }
            if !self.users.isEmpty {
                self.users.remove(at: 0)
            }

            guard let user = self.users[safe: 1] else {
                print(self.users[safe: 1])
                return
            }

            self.view?.newCard(user: user, distance: self.getDistance(latitude: user.latitude ?? 0, longitude: user.longitude ?? 0))

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
            self.view?.showItsMatchView()
        }
    }

    func toChat() {
        guard let id = lastLikedUserID else {
            return
        }

        moduleRouter.toOtherProfile(id: id)
        view?.hideItsMatchView()
    }

    deinit {
        distanceObserver?.invalidate()
    }

    // Метод возвращающий количество изображений у пользователя
    func getCountOfUserImages() -> Int {
        return User.currentUser?.imagePaths.count ?? 0
    }
}

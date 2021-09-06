import Foundation
import Firebase

class User: NSObject, Codable {

    var age: Int {
        get {
            guard let birthday = birthday else {
                return 0
            }

            // Convert DOB to new Date
            let finalDate = Date(timeIntervalSince1970: birthday)

            // Todays Date
            let now = Date()
            // Calender
            let calendar = Calendar.current

            // Get age Components
            let ageComponents = calendar.dateComponents([.year], from: finalDate, to: now)

            return ageComponents.year ?? 0
        }
    }

    var id: String?
    var name: String?
    var email: String?
    var password: String?
    var isMale: Bool?
    @objc dynamic var imagePaths: [String] = [String]()
    @objc dynamic var imageDictionary = [String: Data]()
    @objc dynamic var biography: String?
    @objc dynamic var englishLevel: String?
    var birthday: TimeInterval?
    var education: String?
    @objc dynamic var position: String?
    var likes = [String]()
    var dislikes = [String]()
    var matches = [String]()
    var conversations = [String]()
    var registrationIsFinished: Bool?
    var country: String?
    var city: String?
    var longitude: Double?
    var latitude: Double?


    init(name: String, email: String, password: String, isMale: Bool, registrationIsFinished: Bool? = false) {
        self.name = name
        self.email = email
        self.password = password
        self.isMale = isMale
        self.registrationIsFinished = registrationIsFinished
    }
    
    init(dictionary: [String: Any]) {
        self.id =   dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.password = dictionary["password"] as? String
        self.isMale = dictionary["isMale"] as? Bool
        self.imagePaths = dictionary["imagePaths"] as? [String] ?? []
        self.biography = dictionary["biography"] as? String
        self.englishLevel = dictionary["englishLevel"] as? String
        self.birthday = dictionary["birthday"] as? TimeInterval
        self.position = dictionary["position"] as? String
        self.likes = dictionary["likes"] as? [String] ?? []
        self.dislikes = dictionary["dislikes"] as? [String] ?? []
        self.matches = dictionary["matches"] as? [String] ?? []
        self.conversations = dictionary["conversations"] as? [String] ?? []
        self.registrationIsFinished = dictionary["registrationIsFinished"] as? Bool
        self.country = dictionary["country"] as? String
        self.city = dictionary["city"] as? String
        self.longitude = dictionary["longitude"] as? Double
        self.latitude = dictionary["latitude"] as? Double
    }
    static var currentUser: User?
}

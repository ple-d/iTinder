import Foundation

extension UserDefaults {
    @objc dynamic var distance: Int {
        return integer(forKey: "distance")
    }
}

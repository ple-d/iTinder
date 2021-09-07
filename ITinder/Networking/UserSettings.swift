import Foundation

class UserSettings {
    private enum SettingsKeys: String {
        case distance
    }

    private static let userDefaults = UserDefaults.standard

    static var distance: Int {
        get {
            return userDefaults.integer(forKey: SettingsKeys.distance.rawValue)
        }
        set {
            userDefaults.setValue(newValue, forKey: SettingsKeys.distance.rawValue)
        }
    }
}

import Foundation

class UserSettings {
    private enum SettingsKeys: String {
        case distance
    }

    private static let userDefaults = UserDefaults.standard

    static var distance: Int {
        get {
            guard userDefaults.integer(forKey: SettingsKeys.distance.rawValue) > 0 else {
                return 10000000
            }

            return userDefaults.integer(forKey: SettingsKeys.distance.rawValue)
        }
        set {
            userDefaults.setValue(newValue, forKey: SettingsKeys.distance.rawValue)
        }
    }
}

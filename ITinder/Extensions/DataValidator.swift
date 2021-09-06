import Foundation

class DataValidator {

    // Метод ответственный за проверку валидности имени пользователя
    static func usernameIsValid(_ name: String) -> Bool {
        guard !name.isEmpty else {
            return false
        }

        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)

        return !(predicate.evaluate(with: name))
    }

    // Метод ответственный за проверку валидности электронной почты
    static func emailIsValid(_ email: String) -> Bool {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)

        return predicate.evaluate(with: email)
    }

    // Метод ответственный за проверку валидности пароля пользователя
    static func passwordIsValid(_ password: String) -> Bool {
        return password.count >= 6
    }

    // Метод ответственный за проверку валидности должности
    static func positionIsValid(_ position: String) -> Bool {
        return !position.isEmpty
    }

    // Метод ответственный за проверку валидности биографии
    static func biographyIsValid(_ biography: String) -> Bool {
        return biography.count > 40 && biography.count < 160
    }


}

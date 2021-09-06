import UIKit

protocol ModuleRouterProtocol {
    func initViewController()
    func toResetPassword()
    func toRegistration(authenticationModule: AuthenticationPresenterProtocol)
    func toAbout()
    func toProfile()
    func toEditProfile()
    func toSettings()
    func toChangePassword() 
    func toMatch()
    func toMainApplicationModule()
    func toOtherProfile(user: User)
    func toOnboarding()
    func popToRoot()
    func pop()
    func dissmiss()
}

// Класс отвечающий за переход между модулями (вью) в приложении
final class ModuleRouter: ModuleRouterProtocol {
    private let navigationController: UINavigationController?
    private let moduleBuilder: ModuleBuilderProtocol?

    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }

    // Инициализация модуля "Авторизация"
    func initViewController() {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildAuthenticationModule(moduleRouter: self) else {
                return
            }
            navigationController.viewControllers = [module]
        }
    }

    // Переход к модулю "Восстановление пароля"
    func toResetPassword() {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildResetPasswordModule(moduleRouter: self) else {
                return
            }
            navigationController.present(module, animated: true, completion: .none)
        }
    }

    // Переход к модулю "Регистрация"
    func toRegistration(authenticationModule: AuthenticationPresenterProtocol) {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildRegistrationModule(moduleRouter: self, authenticationModule: authenticationModule) else {
                return
            }
            navigationController.present(module, animated: true, completion: .none)
        }
    }

    // Переход к модулю "Информация о себе"
    func toAbout() {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildAboutModule(moduleRouter: self) else {
                return
            }
            navigationController.pushViewController(module, animated: true)
        }
    }

    // Переход к модулю "Профиль"
    func toProfile() {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildProfileModule(moduleRouter: self) else {
                return
            }
            navigationController.pushViewController(module, animated: true)
        }
    }

    // Переход к модулю "Профиль"
    func toEditProfile() {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildEditProfileModule(moduleRouter: self) else {
                return
            }
            navigationController.present(module, animated: true)
        }
    }

    // Переход к модулю "Настройки"
    func toSettings() {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildSettingsModule(moduleRouter: self) else {
                return
            }
            navigationController.present(module, animated: true)
        }
    }

    // Переход к модулю "Изменение пароля"
    func toChangePassword() {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildChangePasswordModule(moduleRouter: self) else {
                return
            }
            navigationController.present(module, animated: true)
        }
    }

    // Переход к модулю "Поиск пар"
    func toMatch() {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildMatchModule(moduleRouter: self) else {
                return
            }
            navigationController.pushViewController(module, animated: true)
        }
    }


    // Переход к модулю "Введение"
    func toOnboarding() {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildOnboardingModule(moduleRouter: self) else {
                return
            }
            navigationController.pushViewController(module, animated: true)
        }
    }

    // Переход в главное меню
    func toMainApplicationModule () {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildMainApplicationModule(moduleRouter: self) else {
                return
            }
            navigationController.pushViewController(module, animated: true)
        }
    }

    // Переход к модулю "Профиль другого пользователя"
    func toOtherProfile(user: User) {
        if let navigationController = navigationController {
            guard let module = moduleBuilder?.buildOtherProfileModule(moduleRouter: self, user: user) else {
                return
            }
            navigationController.present(module, animated: true)
        }
    }

    // Метод закрывающий все модули кроме корневого
    // Модули удаляются из стека navigationController и памяти
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

    // Метод закрывающий последний модуль (вью)
    // Модуль удаляется из стека navigationController и памяти
    func pop() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }

    func dissmiss() {
        if let navigationController = navigationController {
            navigationController.dismiss(animated: true)
        }
    }
}

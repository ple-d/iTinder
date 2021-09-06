import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    func buildAuthenticationModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
    func buildResetPasswordModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
    func buildRegistrationModule(moduleRouter: ModuleRouterProtocol, authenticationModule: AuthenticationPresenterProtocol) -> UIViewController
    func buildAboutModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
    func buildMainApplicationModule(moduleRouter: ModuleRouterProtocol) -> UITabBarController
    func buildProfileModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
    func buildEditProfileModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
    func buildSettingsModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
    func buildChangePasswordModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
    func buildMatchModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
    func buildСonversationsModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
    func buildOtherProfileModule(moduleRouter: ModuleRouterProtocol, user: User) -> UIViewController
    func buildOnboardingModule(moduleRouter: ModuleRouterProtocol) -> UIViewController
}

// Класс отвечающий за сборку модулей (вью) в приложении
final class ModuleBuilder: ModuleBuilderProtocol {

    // Сборка модуля "Авторизация"
    func buildAuthenticationModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = AuthenticationController()
        view.presenter = AuthenticationPresenter(view: view, moduleRouter: moduleRouter)

        return view
    }

    // Сборка модуля "Восстановление пароля"
    func buildResetPasswordModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = ResetPasswordController()
        view.presenter = ResetPasswordPresenter(view: view, moduleRouter: moduleRouter)

        return view
    }

    // Сборка модуля "Регистрация"
    func buildRegistrationModule(moduleRouter: ModuleRouterProtocol, authenticationModule: AuthenticationPresenterProtocol) -> UIViewController {
        let view = RegistrationController()
        view.presenter = RegistrationPresenter(view: view, moduleRouter: moduleRouter, authenticationModule: authenticationModule)

        return view
    }

    // Сборка модуля "Информация о себе"
    func buildAboutModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = AboutController()
        view.presenter = AboutPresenter(view: view, moduleRouter: moduleRouter)

        return view
    }

    // Сборка модуля "Введение"
    func buildOnboardingModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = OnboardingController()
        view.presenter = OnboardingPresenter(view: view, moduleRouter: moduleRouter)

        return view
    }

    // Сборка модуля "Профиль"
    func buildProfileModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = ProfileController()
        view.presenter = ProfilePresenter(view: view, moduleRouter: moduleRouter)
        view.tabBarItem.image = UIImage(named: "profileIcon")
        view.tabBarItem.title = "Профиль"
        
        return view
    }

    // Сборка модуля "Редактирование профиля"
    func buildEditProfileModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = EditProfileController()
        view.presenter = EditProfilePresenter(view: view, moduleRouter: moduleRouter)

        
        return view
    }

    // Сборка модуля "Настройки"
    func buildSettingsModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = SettingsController()
        view.presenter = SettingsPresenter(view: view, moduleRouter: moduleRouter)

        return view
    }

    // Сборка модуля "Изменение пароля"
    func buildChangePasswordModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = ChangePasswordController()
        view.presenter = ChangePasswordPresenter(view: view, moduleRouter: moduleRouter)

        return view
    }

    // Сборка модуля "Поиск пар"
    func buildMatchModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = MatchController()
        view.presenter = MatchPresenter(view: view, moduleRouter: moduleRouter)
        view.tabBarItem.image = UIImage(named: "searchIcon")
        view.tabBarItem.title = "Поиск пар"
        return view
    }

    // Сборка модуля "Мэтчи и беседы"
    func buildСonversationsModule(moduleRouter: ModuleRouterProtocol) -> UIViewController {
        let view = ConversationsController()
        
        view.tabBarItem.image = UIImage(named: "chatIcon")
        view.tabBarItem.title = "Общение"

        return view
    }

    // Сборка модуля "Профиль другого пользователя"
    func buildOtherProfileModule(moduleRouter: ModuleRouterProtocol, user: User) -> UIViewController {
        let view = OtherProfileController()
        view.presenter = OtherProfilePresenter(view: view, moduleRouter: moduleRouter, user: user)

        return view
    }

    func buildMainApplicationModule(moduleRouter: ModuleRouterProtocol) -> UITabBarController {
        let tabBarController = UITabBarController()

        tabBarController.tabBar.backgroundImage = UIImage.getColorImage(color: .white, size: tabBarController.tabBar.bounds.size)
        tabBarController.setViewControllers([buildProfileModule(moduleRouter: moduleRouter), buildMatchModule(moduleRouter: moduleRouter), buildСonversationsModule(moduleRouter: moduleRouter)], animated: false)

        return tabBarController
    }
}

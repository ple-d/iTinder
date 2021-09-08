import UIKit

protocol OnboardingPresenterProtocol: AnyObject {
    var slides: [OnboardingSlide] { get }
    func toMainApplicationModule()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    private var moduleRouter: ModuleRouterProtocol

    let slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Вы полностью готовы!", text: "Ищите, знакомьтесь и наслаждайтесь. ITinder - безграничный мир единомышленников", image: UIImage(named: "ready") ?? UIImage()),
        OnboardingSlide(title: "Нравится?", text: "Это лайк с первого взгляда. Свайпайте вправо и ждите взаимности. В ином случае двигай пальчик влево", image: UIImage(named: "swipe") ?? UIImage()),
        OnboardingSlide(title: "Общайтесь", text: "После взаимного лайка пора початиться.", image: UIImage(named: "chat") ?? UIImage())
    ]

    init(view: OnboardingViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter
    }

    func toMainApplicationModule() {
        moduleRouter.toMainApplicationModule()
    }

}

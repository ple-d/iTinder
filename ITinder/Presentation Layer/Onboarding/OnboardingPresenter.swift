import UIKit

protocol OnboardingPresenterProtocol: AnyObject {
    var slides: [OnboardingSlide] { get }
    func toMainApplicationModule()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    private var moduleRouter: ModuleRouterProtocol

    let slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Вы полностью готовы!", text: "Ищите, знакомьтесь и наслаждайтесь. ITinder - безграничный мир единомышленников", image: UIImage()),
        OnboardingSlide(title: "Заинтересовались?", text: "Это лайк с первого взгляда. Свайпайте влево и ждите взаимности.", image: UIImage()),
        OnboardingSlide(title: "Не подходит", text: "Не понравился кандидат? Свайпни влево и больше его не увидишь", image: UIImage()),
        OnboardingSlide(title: "Общайтесь", text: "После взаимного лайка пора и пообщаться.", image: UIImage())
    ]

    init(view: OnboardingViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter
    }

    func toMainApplicationModule() {
        moduleRouter.toMainApplicationModule()
    }

}

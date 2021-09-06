import UIKit

protocol OnboardingPresenterProtocol: AnyObject {
    var slides: [OnboardingSlide] { get }
    func toMainApplicationModule()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    private var moduleRouter: ModuleRouterProtocol

    let slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Свайпай влево!1", text: "Не понравился человек? Свайпни влево и больше его не увидишь", image: UIImage()),
        OnboardingSlide(title: "Свайпай влево!2", text: "Не понравился человек? Свайпни влево и больше его не увидишь", image: UIImage()),
        OnboardingSlide(title: "Свайпай влево!3", text: "Не понравился человек? Свайпни влево и больше его не увидишь", image: UIImage())
    ]
    
    init(view: OnboardingViewProtocol, moduleRouter: ModuleRouterProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter
    }

    func toMainApplicationModule() {
        moduleRouter.toMainApplicationModule()
    }

}

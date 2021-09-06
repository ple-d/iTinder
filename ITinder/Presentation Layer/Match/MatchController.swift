import UIKit
import CoreLocation
protocol MatchViewProtocol: AnyObject {
    func setBiography(_ biography: String)
    func newCard(user: User, distance: Int)
    func noCardStackViewIsVisible(_ isVisible: Bool)
    func update()
}

class MatchController: UIViewController, MatchViewProtocol {
    var cards = [CardView]()

    var presenter: MatchPresenterProtocol?

    override func loadView() {
        view = MatchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = view as? MatchView

        view?.anewButton.addTarget(self, action: #selector(anewButtonTouched), for: .touchUpInside)

        let toSettingsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toSettingsActionLabelTouched))
        view?.toSettingsActionLabel.addGestureRecognizer(toSettingsGestureRecognizer)

        let dismissGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissUser))
        view?.dismissButton.addGestureRecognizer(dismissGestureRecognizer)

        let likeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeUser))
        view?.likeButton.addGestureRecognizer(likeGestureRecognizer)
    }

    func update() {
        let view = view as? MatchView
        
        cards.removeAll()
        view?.cardContainer.subviews.forEach { card in
            card.removeFromSuperview()
        }
    }
    
    @objc func dismissUser() {
        guard let card = cards.first else {
            return
        }
        cardDislike(card)
    }

    @objc func likeUser() {
        guard let card = cards.first else {
            return
        }
        cardLike(card)
    }

    @objc func anewButtonTouched() {
        presenter?.anew()
    }

    @objc func toSettingsActionLabelTouched() {
        presenter?.toSettings()
    }

    func noCardStackViewIsVisible(_ isVisible: Bool) {
        let view = view as? MatchView
        view?.noCardStackView.isHidden = !isVisible
        view?.dismissButton.isHidden = isVisible
        view?.likeButton.isHidden = isVisible
    }

    fileprivate func performSwipeAnimation(translation: CGFloat, angle: CGFloat) {
        let duration = 0.5
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.toValue = translation
        translationAnimation.duration = duration
        translationAnimation.fillMode = .forwards
        translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translationAnimation.isRemovedOnCompletion = false

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = angle * CGFloat.pi / 180
        rotationAnimation.duration = duration

        let card = cards.first
        cards.remove(at: 0)

        CATransaction.setCompletionBlock {
            card?.removeFromSuperview()
        }

        card?.layer.add(translationAnimation, forKey: "translation")
        card?.layer.add(rotationAnimation, forKey: "rotation")

        CATransaction.commit()
    }

    func newCard(user: User, distance: Int) {
        let view = view as! MatchView

        let card = CardView()
        card.swipingIsOn = true
        card.translatesAutoresizingMaskIntoConstraints = false
        card.user = user
        card.distance = distance
        card.delegate = self

        if let lastCard = cards.last {
            view.cardContainer.insertSubview(card, belowSubview: lastCard)
        } else {
            view.cardContainer.addSubview(card)
        }
        cards.append(card)

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: view.cardContainer.topAnchor),
            card.leftAnchor.constraint(equalTo: view.cardContainer.leftAnchor),
            card.bottomAnchor.constraint(equalTo: view.cardContainer.bottomAnchor),
            card.rightAnchor.constraint(equalTo: view.cardContainer.rightAnchor)
        ])


    }

    func setBiography(_ biography: String) {
        let view = view as! MatchView
        view.biographyLabel.text = biography
    }
}

extension MatchController: CardViewDelegate {
    func cardLike(_ card: CardView) {
        performSwipeAnimation(translation: 700, angle: 15)
        presenter?.newLike(id: card.user?.id ?? "")
        presenter?.loadUsers(count: 1)

        guard let isMatched = card.user?.likes.contains(User.currentUser?.id ?? ""), isMatched == true else {
            return
        }

        presenter?.newMatch(id: card.user?.id ?? "", matches: card.user?.matches ?? [])
    }

    func cardDislike(_ card: CardView) {
        performSwipeAnimation(translation: -700, angle: -15)
        presenter?.newDislike(id: card.user?.id ?? "")
        presenter?.loadUsers(count: 1)
    }
}

import UIKit
import CoreLocation

protocol OnboardingViewProtocol: AnyObject {

}

import CoreLocation


class OnboardingController: UIViewController, OnboardingViewProtocol {
    var presenter: OnboardingPresenterProtocol?

    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == (presenter?.slides.count ?? 0) - 1 {
                nextButton.setTitle("Начать", for: .normal)
            } else {
                nextButton.setTitle("Дальше", for: .normal)
            }
        }
    }
    
    let background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = UIImage(named: "background")
        return background
    }()

    func backgroundConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.rightAnchor.constraint(equalTo: view.rightAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }

    let onboardingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.59)

        let onboardingCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        onboardingCollection.translatesAutoresizingMaskIntoConstraints = false
        onboardingCollection.showsVerticalScrollIndicator = false
        onboardingCollection.showsHorizontalScrollIndicator = false
        onboardingCollection.isPagingEnabled = true
        onboardingCollection.backgroundColor = .none
        onboardingCollection.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)

        return onboardingCollection
    }()

    func onboardingCollectionConstraints() {
        NSLayoutConstraint.activate([
            onboardingCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.15),
            onboardingCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            onboardingCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            onboardingCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
    }

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = Color.pink
        pageControl.tintColor = Color.gray
        pageControl.pageIndicatorTintColor = Color.gray
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    func pageControlConstraints() {
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: onboardingCollection.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    let nextButton: UIGradientButton = {
        let nextButton = UIGradientButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.clipsToBounds = true
        nextButton.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("Дальше", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return nextButton
    }()

    func nextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            nextButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7 * 0.17),
            nextButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: view.bounds.height * 0.03),
            nextButton.centerXAnchor.constraint(equalTo: pageControl.centerXAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        onboardingCollection.delegate = self
        onboardingCollection.dataSource = self

        view.addSubview(background)
        backgroundConstraints()

        view.addSubview(onboardingCollection)
        onboardingCollectionConstraints()

        view.addSubview(pageControl)
        pageControlConstraints()

        view.addSubview(nextButton)
        nextButtonConstraints()

        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        nextButton.layer.cornerRadius = nextButton.bounds.height / 2
    }

    @objc func nextButtonTouched() {
        if currentPage == (presenter?.slides.count ?? 0) - 1 {
            presenter?.toMainApplicationModule()
        } else {

            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            let rect = self.onboardingCollection.layoutAttributesForItem(at:indexPath)?.frame
                 self.onboardingCollection.scrollRectToVisible(rect!, animated: true)
        }


    }
}

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.slides.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let onboardingCell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier, for: indexPath) as! OnboardingCollectionViewCell

        onboardingCell.titleLabel.text = presenter?.slides[indexPath.item].title
        onboardingCell.textLabel.text = presenter?.slides[indexPath.item].text
        onboardingCell.imageView.image = presenter?.slides[indexPath.item].image
        
        return onboardingCell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

import UIKit

protocol CardViewDelegate: AnyObject {
    func cardLike(_ card: CardView)
    func cardDislike(_ card: CardView)
}

class CardView: UIView {

    weak var delegate: CardViewDelegate?
    weak var user: User? = nil {
        didSet {
            update()
            userImageObserver = user!.observe(\.imageDictionary, options: [.new]) { _, _ in
                self.photoCollection.reloadData()
                self.photoCollectionPageControl.numberOfPages = self.user!.imagePaths.count
                self.currentSlide = 0
                print("Сработал обсервер")
            }
        }
    }

    var distance: Int = 0 {
        didSet {
            locationLabel.text = "\(distance) км от вас"
        }
    }

    var timer: Timer?
    var currentSlide = 0

    var isDismiss = false
    var swipingIsOn = false {
        didSet {
            photoCollection.isUserInteractionEnabled = !swipingIsOn
        }
    }

    var userImageObserver: NSKeyValueObservation?

    // Метод предназначенный для обновления информации в карточке
    func update() {
        nameAndAgeLabel.text = "\(user?.name ?? "Имя"), \(user?.age ?? 0)"
        genderLabel.text = user?.isMale ?? true ? "мужской" : "женский"
        positionLabel.text = "👨‍💻 \(user?.position ?? "Профессия")"
        englishLevelLabel.text = "🇬🇧 \(user?.englishLevel ?? "Уровень английского")"

        photoCollectionPageControl.numberOfPages = user?.imagePaths.count ?? 0
        photoCollection.reloadData()
    }

    let photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 100, height: 100)

        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        photoCollection.isPagingEnabled = true
        photoCollection.showsVerticalScrollIndicator = false
        photoCollection.showsHorizontalScrollIndicator = false
        photoCollection.register(CardPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "Photo")

        return photoCollection
    }()

    func photoCollectionConstraints() {
        NSLayoutConstraint.activate([
            photoCollection.topAnchor.constraint(equalTo: topAnchor),
            photoCollection.leftAnchor.constraint(equalTo: leftAnchor),
            photoCollection.rightAnchor.constraint(equalTo: rightAnchor),
            photoCollection.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }

    func photoCollectionSetLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = photoCollection.bounds.size
        layout.minimumLineSpacing = 0

        photoCollection.setCollectionViewLayout(layout, animated: false)
    }

    let photoCollectionPageControl: UIPageControl = {
        let photoCollectionPageControl = UIPageControl()
        photoCollectionPageControl.translatesAutoresizingMaskIntoConstraints = false
        photoCollectionPageControl.currentPageIndicatorTintColor = Color.pink
        photoCollectionPageControl.tintColor = .white
        photoCollectionPageControl.pageIndicatorTintColor = .white
        photoCollectionPageControl.isUserInteractionEnabled = false

        return photoCollectionPageControl
    }()

    func photoPageControlConstraints() {
        NSLayoutConstraint.activate([
            photoCollectionPageControl.centerXAnchor.constraint(equalTo: photoCollection.centerXAnchor),
            photoCollectionPageControl.bottomAnchor.constraint(equalTo: photoCollection.bottomAnchor, constant: -10)
        ])
    }

    let nameAndAgeLabel: UILabel = {
        let nameAndAgeLabel = UILabel()
        nameAndAgeLabel.translatesAutoresizingMaskIntoConstraints = false
        nameAndAgeLabel.text = "Имя, 0"
        nameAndAgeLabel.textAlignment = .center
        nameAndAgeLabel.textColor = Color.black


        return nameAndAgeLabel
    }()

    func nameAndAgeLabelConstraints() {
        NSLayoutConstraint.activate([
            nameAndAgeLabel.topAnchor.constraint(equalTo: photoCollection.bottomAnchor, constant: UIScreen.main.bounds.height / 70),
            nameAndAgeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: UIScreen.main.bounds.width / 20)
        ])
    }

    let genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.text = "пол"
        genderLabel.textAlignment = .center
        genderLabel.textColor = Color.gray

        return genderLabel
    }()

    func genderLabelConstraints() {
        NSLayoutConstraint.activate([
            genderLabel.bottomAnchor.constraint(equalTo: nameAndAgeLabel.bottomAnchor),
            genderLabel.leftAnchor.constraint(equalTo: nameAndAgeLabel.rightAnchor, constant: UIScreen.main.bounds.width / 40)
        ])
    }

    let positionLabel: UILabel = {
        let positionLabel = UILabel()
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.text = "👨‍💻 Профессия"
        positionLabel.textAlignment = .center
        positionLabel.textColor = Color.gray

        return positionLabel
    }()

    func positionLabelConstraints() {
        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: nameAndAgeLabel.bottomAnchor, constant: UIScreen.main.bounds.height / 85),
            positionLabel.leftAnchor.constraint(equalTo: nameAndAgeLabel.leftAnchor)
        ])
    }

    let englishLevelLabel: UILabel = {
        let englishLevelLabel = UILabel()
        englishLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        englishLevelLabel.text = "🇬🇧 Уровень английского"
        englishLevelLabel.textAlignment = .center
        englishLevelLabel.textColor = Color.gray

        return englishLevelLabel
    }()

    func englishLevelLabelConstraints() {
        NSLayoutConstraint.activate([
            englishLevelLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: UIScreen.main.bounds.height / 100),
            englishLevelLabel.leftAnchor.constraint(equalTo: positionLabel.leftAnchor)
        ])
    }

    let locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = ""
        locationLabel.textAlignment = .right
        locationLabel.textColor = Color.gray

        return locationLabel
    }()

    func locationLabelLabelConstraints() {
        NSLayoutConstraint.activate([
            locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 100),
            locationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -UIScreen.main.bounds.height / 50)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        photoCollection.delegate = self
        photoCollection.dataSource = self
        
        backgroundColor = .white

        addSubview(photoCollection)
        photoCollectionConstraints()

        addSubview(photoCollectionPageControl)
        photoPageControlConstraints()

        addSubview(nameAndAgeLabel)
        nameAndAgeLabelConstraints()

        addSubview(genderLabel)
        genderLabelConstraints()

        addSubview(positionLabel)
        positionLabelConstraints()

        addSubview(englishLevelLabel)
        englishLevelLabelConstraints()

        addSubview(locationLabel)
        locationLabelLabelConstraints()

        photoCollectionPageControl.numberOfPages = 3
        photoCollectionPageControl.currentPage = 0

        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.07
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)

        DispatchQueue.main.async { [weak self] in
            self?.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self?.slideImage), userInfo: nil, repeats: true)
        }
    }

    fileprivate func handleEnded(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gestureRecognizer.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gestureRecognizer.translation(in: nil).x) > 80

        if shouldDismissCard {
            if translationDirection == 1 {
                delegate?.cardLike(self)
            } else {
                delegate?.cardDislike(self)
            }
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.transform = .identity
            })
        }
    }

    fileprivate func handleChanged(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: nil)

        let degrees: CGFloat = translation.x / 60
        let angle = degrees * .pi / 180

        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)

    }

    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        guard swipingIsOn else {
            return
        }

        switch gestureRecognizer.state {
        case .changed:
            handleChanged(gestureRecognizer)
        case .ended:
            handleEnded(gestureRecognizer)
        default:
            break
        }

    }

    @objc func slideImage() {
        guard swipingIsOn else {
            return
        }

        if currentSlide < user?.imagePaths.count ?? 0 {
            let index = IndexPath.init(item: currentSlide, section: 0)
            photoCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            photoCollectionPageControl.currentPage = currentSlide
            currentSlide += 1
        } else {
            currentSlide = 0
            let index = IndexPath.init(item: currentSlide, section: 0)
            photoCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            photoCollectionPageControl.currentPage = currentSlide
            currentSlide += 1
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = bounds.height / 16
        photoCollection.layer.cornerRadius = bounds.height / 16
        photoCollection.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        photoCollectionSetLayout()

        nameAndAgeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: bounds.height * 0.05)
        positionLabel.font = UIFont(name: "HelveticaNeue", size: bounds.height * 0.025)
        positionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: bounds.height * 0.035)
        englishLevelLabel.font = UIFont(name: "HelveticaNeue-Medium", size: bounds.height * 0.035)
        locationLabel.font = UIFont(name: "HelveticaNeue-Medium", size: bounds.height * 0.035)
    }
}

extension CardView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.imagePaths.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as! CardPhotoCollectionViewCell

        let imagePath = user?.imagePaths[safe: indexPath.item] ?? String()
        let imageData = user?.imageDictionary[imagePath] ?? Data()
        photo.photo.image = UIImage(data: imageData)
        return photo
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        currentSlide = Int(scrollView.contentOffset.x / width)
    }
}

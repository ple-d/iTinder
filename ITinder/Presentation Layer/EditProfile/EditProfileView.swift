import UIKit

class EditProfileView: UIView {

    // Фон
    let background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = UIImage(named: "background")
        return background
    }()

    func backgroundConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.rightAnchor.constraint(equalTo: rightAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            background.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }

    // Заголовок "Редактирование"
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Редактирование"
        title.textAlignment = .center
        title.textColor = appColor.black
        title.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)

        return title
    }()

    func titleConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height / 16),
            title.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Коллекция с изображениями пользователя
    let photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.height * 0.13 * 0.75, height: UIScreen.main.bounds.height * 0.13)
        layout.minimumLineSpacing = UIScreen.main.bounds.width * 0.04

        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        photoCollection.contentInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width * 0.07, bottom: 0, right: UIScreen.main.bounds.width * 0.07)
        photoCollection.showsVerticalScrollIndicator = false
        photoCollection.showsHorizontalScrollIndicator = false

        photoCollection.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "Photo")
        photoCollection.backgroundColor = .none

        return photoCollection
    }()

    func photoCollectionConstraints() {
        NSLayoutConstraint.activate([
            photoCollection.topAnchor.constraint(equalTo: title.bottomAnchor, constant: UIScreen.main.bounds.height * 0.045),
            photoCollection.leftAnchor.constraint(equalTo: self.leftAnchor),
            photoCollection.rightAnchor.constraint(equalTo: self.rightAnchor),
            photoCollection.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.14)
        ])
    }

    // Текстовое поле "Биография"
    let biographyTextField: UIGradientTextField = {
        let biographyTextField = UIGradientTextField()
        biographyTextField.translatesAutoresizingMaskIntoConstraints = false
        biographyTextField.backgroundColor = .white
        biographyTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        biographyTextField.textColor = appColor.black
        biographyTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        biographyTextField.placeholderLabel.text = "Биография    \u{200c}"
        biographyTextField.autocorrectionType = .no

        return biographyTextField
    }()

    func biographyTextFieldConstraints() {
        NSLayoutConstraint.activate([
            biographyTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            biographyTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
            biographyTextField.topAnchor.constraint(equalTo: photoCollection.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            biographyTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Текстовое поле "Дата рождения"
    let birthdayTextField: UIGradientTextField = {
        let birthdayTextField = UIGradientTextField()
        birthdayTextField.translatesAutoresizingMaskIntoConstraints = false
        birthdayTextField.backgroundColor = .white
        birthdayTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        birthdayTextField.textColor = appColor.black
        birthdayTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        birthdayTextField.placeholderLabel.text = "Дата рождения    \u{200c}"

        return birthdayTextField
    }()

    func birthdayTextFieldConstraints() {
        NSLayoutConstraint.activate([
            birthdayTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            birthdayTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
            birthdayTextField.topAnchor.constraint(equalTo: biographyTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            birthdayTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Текстовое поле "Уровень английского"
    let englishLevelTextField: UIGradientTextField = {
        let englishLevelTextField = UIGradientTextField()
        englishLevelTextField.translatesAutoresizingMaskIntoConstraints = false
        englishLevelTextField.backgroundColor = .white
        englishLevelTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        englishLevelTextField.textColor = appColor.black
        englishLevelTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        englishLevelTextField.placeholderLabel.text = "Уровень английского    \u{200c}"

        return englishLevelTextField
    }()

    func englishLevelTextFieldConstraints() {
        NSLayoutConstraint.activate([
            englishLevelTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            englishLevelTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
            englishLevelTextField.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            englishLevelTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Текстовое поле "Должность"
    let positionTextField: UIGradientTextField = {
        let positionTextField = UIGradientTextField()
        positionTextField.translatesAutoresizingMaskIntoConstraints = false
        positionTextField.backgroundColor = .white
        positionTextField.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        positionTextField.textColor = appColor.black
        positionTextField.font = UIFont(name: "HelveticaNeue", size: UIScreen.main.bounds.height * 0.018)
        positionTextField.placeholderLabel.text = "Должность    \u{200c}"
        positionTextField.autocorrectionType = .no

        return positionTextField
    }()

    func positionTextFieldConstraints() {
        NSLayoutConstraint.activate([
            positionTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            positionTextField.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
            positionTextField.topAnchor.constraint(equalTo: englishLevelTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            positionTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Кнопка "Начать"
    let startButton: UIGradientButton = {
        let startButton = UIGradientButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.clipsToBounds = true
        startButton.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitle("Начать", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return startButton
    }()

    func startButtonConstraints() {
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            startButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7 * 0.17),
            startButton.topAnchor.constraint(equalTo: positionTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.033),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // Логотип
    let gradientLogo: UIGradientLabel = {
        let gradientLogo = UIGradientLabel()
        gradientLogo.translatesAutoresizingMaskIntoConstraints = false
        gradientLogo.text = "ITinder"
        gradientLogo.gradientColors = [appColor.pink.cgColor, appColor.blue.cgColor]
        gradientLogo.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.035)

        return gradientLogo
    }()

    func gradientLogoConstraints() {
        NSLayoutConstraint.activate([
            gradientLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            gradientLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 16)
        ])
    }

    let birthdayPicker: UIDatePicker = {
        let birthdayPicker = UIDatePicker()
        birthdayPicker.datePickerMode = .date
        birthdayPicker.preferredDatePickerStyle = .wheels
        birthdayPicker.maximumDate = Date()

        return birthdayPicker
    }()

    let englishLevelPicker: UIPickerView = {
        let englishLevelPicker = UIPickerView()

        return englishLevelPicker
    }()

    // Поп-ап
    let warningView: UIWarningView = {
        let warningView = UIWarningView()
        warningView.translatesAutoresizingMaskIntoConstraints = false

        return warningView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(background)
        backgroundConstraints()

        addSubview(title)
        titleConstraints()

        addSubview(photoCollection)
        photoCollectionConstraints()

        addSubview(biographyTextField)
        biographyTextFieldConstraints()

        addSubview(birthdayTextField)
        birthdayTextFieldConstraints()

        addSubview(englishLevelTextField)
        englishLevelTextFieldConstraints()

        addSubview(positionTextField)
        positionTextFieldConstraints()

        addSubview(startButton)
        startButtonConstraints()

        addSubview(gradientLogo)
        gradientLogoConstraints()

        addSubview(warningView)
        warningView.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()

        biographyTextField.layer.cornerRadius = biographyTextField.bounds.height / 2
        birthdayTextField.layer.cornerRadius = birthdayTextField.bounds.height / 2
        englishLevelTextField.layer.cornerRadius = englishLevelTextField.bounds.height / 2
        positionTextField.layer.cornerRadius = positionTextField.bounds.height / 2
        startButton.layer.cornerRadius = startButton.bounds.height / 2
    }
}

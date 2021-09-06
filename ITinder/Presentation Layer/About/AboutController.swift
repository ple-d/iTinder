import UIKit
import CoreLocation

protocol AboutViewProtocol: AnyObject {
    func reloadPhotoCollection()
    func showWarning(title: String, text: String)
    func hideWarning()
}

class AboutController: UIViewController, AboutViewProtocol {

    var presenter: AboutPresenterProtocol?
    private let imagePicker = UIImagePickerController()

    private var locationManager =  CLLocationManager()
    private var geoCoder = CLGeocoder()

    let englishLevels = ["A1 - Beginner", "A2 - Elementary", "A2/B1 - Pre-Intermediate", "B1 - Intermediate", "B2 - Upper-Intermediate", "C1 - Advanced", "C2 - Proficiency"]

    override func loadView() {
        view = AboutView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = view as? AboutView

        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        view?.photoCollection.delegate = self
        view?.photoCollection.dataSource = self


        view?.birthdayTextField.inputView = view?.birthdayPicker
        view?.birthdayPicker.addTarget(self, action: #selector(birthdayIsSelected), for: .valueChanged)

        view?.englishLevelTextField.inputView = view?.englishLevelPicker
        view?.englishLevelPicker.delegate = self
        view?.englishLevelPicker.dataSource = self

//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
//        view?.addGestureRecognizer(tapGesture)
        view?.startButton.addTarget(self, action: #selector(startButtonTouched), for: .touchUpInside)

        let toAuthenticationGesture = UITapGestureRecognizer(target: self, action: #selector(toAuthenticationTouched))
        view?.toAuthenticationActionLabel.addGestureRecognizer(toAuthenticationGesture)
        

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    // Метод для показа предупреждения
    func showWarning(title: String, text: String) {
        let view = view as? AboutView

        view?.warningView.show(title: title, text: text)
    }

    // Метод для скрытия предупреждения
    func hideWarning()  {
        let view = view as? AboutView
        
        view?.warningView.hide() {}
    }

    @objc func toAuthenticationTouched() {
        presenter?.toAuthentication()
    }

    // Обновление данных в photoCollection
    func reloadPhotoCollection() {
        let view = view as? AboutView

        view?.photoCollection.reloadData()
    }

    // Метод срабатывающий при выборе даты рождения
    @objc func birthdayIsSelected() {
        let view = view as? AboutView

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        view?.birthdayTextField.text = dateFormatter.string(from: view?.birthdayPicker.date ?? Date())
    }

    @objc func removeImage(_ sender: UITapGestureRecognizer) {
        let view = view as? AboutView

        guard let index = sender.view?.tag else {
            return
        }

        guard presenter?.getCountOfUserImages() ?? 0 != 1 else {
            showWarning(title: "Ошибочка!", text: "Оставьте хотя бы одну фотографию. Она же классная!")
            return
        }

        presenter?.removeImage(index: index)
    }

    @objc func startButtonTouched() {
        let view = view as? AboutView

        guard let biography = view?.biographyTextField.text else {
            return
        }

        guard let birthday = view?.birthdayPicker.date, view?.birthdayTextField.text ?? "" != "" else {
            showWarning(title: "Ошибочка!", text: "А сколько вам годиков?")
            return
        }

        guard let englishLevel = view?.englishLevelTextField.text else {
            return
        }

        guard let position = view?.positionTextField.text else {
            return
        }

        presenter?.start(biography: biography, birthday: birthday, englishLevel: englishLevel, position: position)

    }

//    // Отмена ввода
//    @objc func tapGesture() {
//        view.endEditing(false)
//    }
}

extension AboutController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter?.getCountOfUserImages() ?? 0 ) + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as! PhotoCollectionViewCell
        
        guard indexPath.item != presenter?.getCountOfUserImages() ?? 0 else {
            photo.setAsAddButton()
            return photo
        }

        let imagePath = User.currentUser?.imagePaths[safe: indexPath.item] ?? String()
        let imageData = User.currentUser?.imageDictionary[imagePath] ?? Data()
        photo.setImageData(imageData: imageData)

        let deleteImageGesture = UITapGestureRecognizer(target: self, action: #selector(removeImage(_:)))

        photo.deleteButton.tag = indexPath.item
        photo.deleteButton.addGestureRecognizer(deleteImageGesture)

        return photo
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == presenter?.getCountOfUserImages() ?? 0  {
            present(imagePicker, animated: true)
        }
    }
}

extension AboutController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let view = self.view as! AboutView

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            guard let imageData = image.jpegData(compressionQuality: 0.4) else {
                return
            }

            presenter?.loadImageData(data: imageData)

        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension AboutController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return englishLevels.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return englishLevels[safe: row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let view = view as? AboutView

        view?.englishLevelTextField.text = englishLevels[safe: row]
    }
}

extension AboutController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }

        geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            guard let currentLocPlacemark = placemarks?.first else { return }
            
            self.presenter?.newUserLocation(country: currentLocPlacemark.country ?? "unknown", city: currentLocPlacemark.locality ?? "unknown", longitude: currentLocation.coordinate.longitude, latitude: currentLocation.coordinate.latitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }
}

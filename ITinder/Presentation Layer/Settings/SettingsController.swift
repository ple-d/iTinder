import UIKit
import CoreLocation

protocol SettingsViewProtocol: AnyObject {

}

class SettingsController: UIViewController, SettingsViewProtocol {
    var presenter: SettingsPresenterProtocol?

    private var locationManager =  CLLocationManager()
    private var geoCoder = CLGeocoder()
    
    override func loadView() {
        view = SettingsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = view as? SettingsView

        setSegmentedControlValue()

        let updateLocationTap = UITapGestureRecognizer(target: self, action: #selector(updateLocationTouched))
        view?.updateLocationActionLabel.addGestureRecognizer(updateLocationTap)

        let toChangePasswordTap = UITapGestureRecognizer(target: self, action: #selector(toChangePasswordTouched))
        view?.changePasswordActionLabel.addGestureRecognizer(toChangePasswordTap)

        let toChangeEmailTap = UITapGestureRecognizer(target: self, action: #selector(toChangeEmailTouched))
        view?.changeEmailActionLabel.addGestureRecognizer(toChangeEmailTap)

        let toAuthenticationTap = UITapGestureRecognizer(target: self, action: #selector(toAuthenticationTouched))
        view?.toAuthenticationActionLabel.addGestureRecognizer(toAuthenticationTap)

        view?.distanceSegmentedControl.addTarget(self, action: #selector(newDistance), for: .valueChanged)
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }

    @objc func newDistance() {
        let view = view as? SettingsView
        let selectedItem = view?.distanceSegmentedControl.selectedSegmentIndex
        var distance: Int?

        switch selectedItem {
        case 0:
            distance = 20
        case 1:
            distance = 100
        case 2:
            distance = 1000
        default:
            break
        }

        UserSettings.distance = distance ?? 10000000
    }

    func setSegmentedControlValue() {
        let view = view as? SettingsView

        var index = 0

        switch  UserSettings.distance {
        case 20:
            index = 0
        case 100:
            index = 1
        case 1000:
            index = 2
        default:
            index = 3
            break
        }

        view?.distanceSegmentedControl.selectedSegmentIndex = index

    }

    @objc func updateLocationTouched() {
        locationManager.requestLocation()
    }

    @objc func toChangePasswordTouched() {
        presenter?.toChangePassword()
    }

    @objc func toChangeEmailTouched() {

    }

    @objc func toAuthenticationTouched() {
        presenter?.toAuthentication()
    }
}

extension SettingsController: CLLocationManagerDelegate {
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


//
//  LocationManager.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 27.08.2022.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    typealias Listener = (String?) -> Void
    static var shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    private var location: Listener?
    
    var currentLocation: String? {
        didSet {
            location?(currentLocation)
        }
    }
    
    func bindLocation(listener: @escaping Listener) {
        self.location = listener
        listener(currentLocation)
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            CLGeocoder().reverseGeocodeLocation(lastLocation) { place, _ in
                self.currentLocation = place?.first?.locality
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
}

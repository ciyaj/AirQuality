//
//  LocationManager.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/14/23.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManagerDelegate: AnyObject {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: LocationCoordinates)
    func locationManager(_ manager: LocationManager, didFailError error: Error)
}

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    private var locationPublisher = PassthroughSubject<LocationCoordinates, Never>()
    private var subscriber: AnyCancellable?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 5
        locationManager.requestWhenInUseAuthorization()
        subscriber = locationPublisher
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .sink{ [weak self] location in
                guard let self = self else { return }
                self.delegate?.locationManager(self, didUpdateLocation:  location)
            }
    }
    func requestLocation() {
        locationManager.startUpdatingLocation()
    }
    
    
}
    
    extension LocationManager: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let newLocation = locations.last else {return }
            let location = LocationCoordinates(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
            print("Got your location", location.latitude, location.longitude)
            locationPublisher.send(location)
            locationManager.stopUpdatingLocation()
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error getting location")
            delegate?.locationManager(self, didFailError: error)
            locationManager.stopUpdatingLocation()
        }
    }

//
//  LocationSearchViewModel.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/14/23.
//

import Foundation

@MainActor
class LocationSearchViewModel: ObservableObject {
    private let locationService = LocationSearchService()
    private let locationManager = LocationManager()
    @Published var state: LocationSearchLoadingState = .idle
    
    init() {
        locationManager.delegate = self
    }
    
    func requestLocation() {
        state = .loading
        locationManager.requestLocation()
    }
    
    func createLocations(latitude: Double, longitude: Double) {
        Task {
            do {
                let newLocations = try await locationService.searchLocation(latitude: latitude, longitude: longitude)
                state = .success(locations: newLocations)
            } catch {
                state = .error(message: error.localizedDescription)
                print(state)
            }
        }
    }
}

extension LocationSearchViewModel: LocationManagerDelegate {
    
    func locationManager(_ manager: LocationManager, didUpdateLocation location: LocationCoordinates) {
        self.createLocations(latitude: location.latitude, longitude: location.longitude)
    }
    
    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        state = .error(message: error.localizedDescription)
    }
}

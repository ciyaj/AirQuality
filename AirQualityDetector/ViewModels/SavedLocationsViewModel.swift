//
//  SavedLocationsViewModel.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/16/23.
//

import SwiftUI

@MainActor
class SavedLocationsViewModel: ObservableObject {
//    #warning("delete the service")
//    private let service = RecipeSearchService()
    let defaults = UserDefaults.standard
    @Published var savedLocations: [LocationQuality] {
        didSet {
            let encoder = JSONEncoder()
            if let encodedLocations = try? encoder.encode(savedLocations) {
                defaults.set(encodedLocations, forKey: "savedLocations")
            }
        }
    }

    init() {
        self.savedLocations = []
        if let saved = defaults.object(forKey: "savedLocations") as? Data {
            let decoder = JSONDecoder()
            do {
                let savedLocationsList = try decoder.decode([LocationQuality].self, from: saved)
                self.savedLocations = savedLocationsList
                print(savedLocations)
                } catch {
                    print("Error decoding savedLocations: \(error)")
                    self.savedLocations = [] // Initialize the array here if there's an error
                }
            } else {
                self.savedLocations = [] // Initialize the array here if there's no data in UserDefaults
                print("no save")
            }
    }

    private let saveKey = "Bookmarked"

    func containsLocation(_ location: LocationQuality) -> Bool {
        return savedLocations.contains {
            $0.data.city == location.data.city
        }
    }

    func addLocation(_ location: LocationQuality) {
        DispatchQueue.main.async {
            self.savedLocations.append(location)
            self.objectWillChange.send()
        }
    }
    func removeLocation(_ location: LocationQuality) {
        var i: Int = 0
        for element in savedLocations {
            if(element.data.city == location.data.city) {
                savedLocations.remove(at: i)
                self.objectWillChange.send()
                break
            }
            else {
                i += 1
            }
        }
    }
}

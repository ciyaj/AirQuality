//
//  LocationQuality.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/14/23.
//

import Foundation
import CoreLocation

// MARK: - LocationQuality
struct LocationQuality: Codable {
    let status: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let city, state, country: String
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let pollution: Pollution
    let weather: Weather
}

// MARK: - Pollution
struct Pollution: Codable {
    let ts: String
    let aqius: Int
    let mainus: String
    let aqicn: Int
    let maincn: String
}

// MARK: - Weather
struct Weather: Codable {
    let ts: String
    let tp, pr, hu: Int
    let ws: Double
    let wd: Int
    let ic: String
}

// MARK: - Location
struct Location: Codable {
    let type: String
    let coordinates: [Double]
}


extension LocationQuality {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        print(decoder)
        return decoder
    }
}

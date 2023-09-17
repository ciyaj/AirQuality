//
//  LocationSearchLoadingState.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/14/23.
//

import Foundation

enum LocationSearchLoadingState {
    case idle
    case loading
    case success(locations: LocationQuality)
    case error(message: String)
}

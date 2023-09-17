//
//  LocationSearchService.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/14/23.
//

import Foundation
import CoreLocation

struct LocationSearchService {
    private let session: URLSession = .shared
    private let decoder: JSONDecoder = LocationQuality.decoder
    
    public func searchLocation(latitude: Double, longitude: Double) async throws -> LocationQuality {
        print("searchLocation called")
        
        let urlString = URLComponents(string: "https://api.airvisual.com/v2/nearest_city?lat=\(latitude)&lon=\(longitude)&key=80d870b3-aeca-47fc-a6c8-b1ba5aaa7b95")
        guard let url = urlString?.url else {
            fatalError("Invalid URL") }
        
        print(url.absoluteString)
        
        let (data, _) = try await session.data(from: url)
        
        let response = try decoder.decode(LocationQuality.self, from: data)
        // Return the decoded name
        return response
    }
}

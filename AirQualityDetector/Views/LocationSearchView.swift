//
//  LocationSearchView.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/14/23.
//

import SwiftUI

struct LocationSearchView: View {
    @StateObject private var vm = LocationSearchViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button("Find air quality near me", action: {
                        vm.requestLocation()
                    }).foregroundColor(.purple)
                }
                Section {
                    switch vm.state {
                    case .idle:
                        Text("Click above to see the air quality near you!")
                    case .loading:
                        ProgressView()
                    case .success(locations: let locations):
                       // Make the gradient fill the entire view
                        VStack {
                            BookmarkView(location: locations, bookvm: SavedLocationsViewModel())
                                .padding()
                            LocationDetailsView(locations: locations)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 5)
                        )
                    case .error(message: let message):
                        Text(message)
                    }
                }
            }
        }
    }
}

struct BookmarkView: View {
    let location: LocationQuality
    @StateObject var bookvm: SavedLocationsViewModel
    var body: some View {
        HStack {
            Button {
                if isSaved {
                    bookvm.removeLocation(location)
                } else {
                    bookvm.addLocation(location)
                  
                }
                
            } label: {
                if isSaved {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.purple)
                } else {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.purple)
                }
            }
            .padding(.leading, 210)
            .foregroundColor(.purple)
        }
    }

    var isSaved: Bool {
        return bookvm.containsLocation(location)
    }
}

struct LocationDetailsView: View {
    var locations: LocationQuality
    var body: some View {
            Divider()
                .frame(height: 1)
                .overlay(Color.purple)
            Text("Location: \(locations.data.city)")
                .fontWeight(.semibold)
            + Text(", "  + "\(locations.data.state)")
                .fontWeight(.semibold)
            + Text(", " + "\(locations.data.country)")
                .fontWeight(.semibold)
            Divider()
                .frame(height: 1)
                .overlay(Color.purple)
            Text("Temperature: \(convertTemp(locations.data.current.weather.tp))° Fahrenheit")
                .fontWeight(.bold)
                .padding()
            Divider()
                .frame(height: 1)
                .overlay(Color.purple)
            Text("Air Quality: \(locations.data.current.pollution.aqius)")
                .foregroundColor(textColorForValue(locations.data.current.pollution.aqius))
                .font(.largeTitle)
                .padding()
        
    }
    
    private func textColorForValue(_ value: Int) -> Color {
        if value >= 0 && value <= 50 {
            return .green
        } else if value >= 51 && value <= 100 {
            return .yellow
        } else if value >= 101 && value <= 150 {
            return .orange
        } else if value >= 151 && value <= 200 {
            return .red
        } else if value >= 201 && value <= 300 {
            return .purple
        } else {
            return .brown
        }
    }
    
    private func convertTemp(_ c: Int) -> Int {
        let f = (c*9/5) + 32
        return f
    }
    
}


struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}

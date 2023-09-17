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
            ZStack {
                VStack {
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
                                LocationDetailsView(locations: locations)
                                .listRowBackground(Color.purple)
                            case .error(message: let message):
                                Text(message)
                            }
                        }
                        
                    }
                    .background(.clear)
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
                        .foregroundColor(.white)
                } else {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
            .padding(.leading, 210)
            .foregroundColor(.white)
        }
    }

    var isSaved: Bool {
        return bookvm.containsLocation(location)
    }
}


struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}

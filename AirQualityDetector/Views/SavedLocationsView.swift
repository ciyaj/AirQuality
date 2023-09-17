//
//  SavedLocationsView.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/16/23.
//

import SwiftUI

struct SavedLocationsView: View {
    @StateObject private var vm = SavedLocationsViewModel()

    var body: some View {
        NavigationStack {
            savedLocationsList
        }
    }
    
    private var savedLocationsList: some View {
        ScrollView {
            ForEach(vm.savedLocations, id: \.data.city) { locations in
                NavigationLink {
                    LocationDetailsView(locations: locations)
                }
            label: {
                    HStack {
                        miniLocationView(location: locations)
                            .padding(.leading)
                        Spacer()
                    }
                }
                Divider()
                    .overlay(Color.purple)

            }
        }
    }
}
    struct miniLocationView: View {
        let location: LocationQuality
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(location.data.city), \(location.data.state)")
//                        .font(.custom("RobotoCondensed-Regular", size: 25))
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                        .padding(.top)
                        .padding(.bottom)
                    Text(location.data.country)
//                        .font(.custom("RobotoCondensed-Regular", size: 20))
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                .padding(.leading)
                Spacer()
            }
        }
    }
struct SavedLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedLocationsView()
    }
}

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
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
    }
}

struct LocationDetailsView: View {
    var locations: LocationQuality
    var body: some View {
        ZStack {
            Color.purple
            VStack(alignment: .leading, spacing: 10) {
                VStack (alignment: .trailing) {
                    BookmarkView(location: locations, bookvm: SavedLocationsViewModel())
                        .padding()
                }
                
                Text("Air Quality for: ")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                HStack {
                    Text("\(locations.data.city), ")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("\(locations.data.state), ")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("\(locations.data.country)")
                    
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding(.leading, 20)
                Divider()
                    .background(Color.white)
                    .frame(height: 1)
                
                Text("Temperature:")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                Text("\(convertTemp(locations.data.current.weather.tp))° Fahrenheit")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                Divider()
                    .background(Color.white)
                    .frame(height: 1)
                
                Text("Air Quality:")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                Text("\(locations.data.current.pollution.aqius)")
                    .foregroundColor(textColorForValue(locations.data.current.pollution.aqius))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 20)
                RoundedRectangle(cornerRadius: 20) // Rounded rectangle
                                .foregroundColor(.white) // Rectangle color
                                .frame(width: 300, height: 150) // Rectangle size
                                .overlay(
                                    Text("\(advisory(locations.data.current.pollution.aqius))")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(textColorForValue(locations.data.current.pollution.aqius))
                                        .padding()
                                )
                                .padding()
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
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
    
    private func advisory(_ value: Int) -> Text {
        if value >= 0 && value <= 50 {
            return Text("Air quality is satisfactory, and air pollution poses little or no risk.")
        } else if value >= 51 && value <= 100 {
            return Text("Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution.")
        } else if value >= 101 && value <= 150 {
            return Text("Members of sensitive groups may experience health effects. The general public is less likely to be affected.")
        } else if value >= 151 && value <= 200 {
            return Text("Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects.")
        } else if value >= 201 && value <= 300 {
            return Text("Health alert: The risk of health effects is increased for everyone.")
        } else {
            return Text("Health warning of emergency conditions: everyone is more likely to be affected.")
        }
    }
}
    


    struct miniLocationView: View {
        let location: LocationQuality
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(location.data.city), \(location.data.state)")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.bottom)
                    Text(location.data.country)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
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

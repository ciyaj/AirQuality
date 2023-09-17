//
//  ContentView.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
//                Text("Welcome to the Air Quality App!")
//                    .font(.system(size: 50))
//                    .padding()
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all) // Make the gradient fill the entire view
                            .overlay(
                                Text("Welcome to the Air Quality App!")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            )
                VStack {
                    Spacer()
                    NavigationLink {
                        LocationSearchView()
                    } label: {
                        HStack {
                            Text("See the air quality near you right now!")
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .background(Color.purple)
                        .cornerRadius(10)
                    }
                    NavigationLink { SavedLocationsView()
                    } label: {
                        HStack {
                            Text("View your saved cities")
                                .foregroundColor(.purple)
                            
                        }
                        .padding(10)
                    }
                }
            }
        }
    }
}

//struct LocationTransitionView: View {
//    var body: some View {
//        NavigationLink {
//            LocationSearchView()
//        } label: {
//           HStack {
//               Text("See the Air Quality near you right now!")
//                    .foregroundColor(.white)
//           }
//           .padding(10)
//           .background(Color.purple)
//           .cornerRadius(10)
//        }
//    }
//}
//
//
//struct SavedLocationTransitionView: View {
//    var body: some View {
//        NavigationLink { SavedLocationsView()
//        } label: {
//           HStack {
//               Text("View your saved cities")
//                    .foregroundColor(.purple)
//           }
//           .padding(10)
//        }
//
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

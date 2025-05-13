//
//  StationViewModel.swift
//  GridCharge
//
//  Created by Michael Lam on 5/5/2025.
//

// moved out of StationLoader for simplicity and readability

import Foundation
import CoreLocation

class StationViewModel: ObservableObject {
    @Published var acStations: [ChargingStation] = []
    @Published var dcStations: [ChargingStation] = []
    @Published var upcomingStations: [UpcomingChargingStation] = []
    @Published var communityStations: [ChargingStation] = []
    //Above 4 variables store lists of different types of charging station
    init() {
        loadAllStations()
    }
//initialises the class
    private func loadAllStations() {
        acStations = loadACStations()
        dcStations = loadDCStations()
        upcomingStations = loadUpcomingStations()
        communityStations = loadCommunityStations()
    }
    //above function loads all the data for the model
    //the function below details how for each type of station, there would be
    // an array of stations, and each station will have its own annotation on the map
    //for example, in the array of AC stations from the JSON file, for each station a
    // a stationAnnoation() is created and added to the annotations array
    func createAnnotations(acStations: [ChargingStation], dcStations: [ChargingStation], upcomingStations: [UpcomingChargingStation], communityStations: [ChargingStation]) -> [StationAnnotation] {
        var annotations: [StationAnnotation] = []

        for station in acStations {
            let coord = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
            annotations.append(StationAnnotation(station: station, coordinate: coord, title: station.stationName, chargerType: .ac))
        }

        for station in dcStations {
            let coord = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
            
            // filters tesla superchargers
            let type : ChargerType = station.operatorName == "Tesla Supercharge" ? .tesla : .dc
            
            annotations.append(StationAnnotation(station: station, coordinate: coord, title: station.stationName, chargerType: type))
        }

        for station in upcomingStations {
            let coord = CLLocationCoordinate2D(latitude: station.lat, longitude: station.lng)
            annotations.append(StationAnnotation(coordinate: coord, title: station.siteAddress, chargerType: .upcoming))
        }
        
        for station in communityStations {
            let coord = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
            annotations.append(StationAnnotation(station: station, coordinate: coord, title: station.stationName, chargerType: .community))
        }

        return annotations
    }
}

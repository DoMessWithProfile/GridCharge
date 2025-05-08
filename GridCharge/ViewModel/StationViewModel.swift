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

    init() {
        loadAllStations()
    }

    private func loadAllStations() {
        acStations = loadACStations()
        dcStations = loadDCStations()
        upcomingStations = loadUpcomingStations()
        communityStations = loadCommunityStations()
    }
    
    func createAnnotations(acStations: [ChargingStation], dcStations: [ChargingStation], upcomingStations: [UpcomingChargingStation], communityStations: [ChargingStation]) -> [StationAnnotation] {
        var annotations: [StationAnnotation] = []

        for station in acStations {
            let coord = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
            annotations.append(StationAnnotation(station: station, coordinate: coord, title: station.stationName, chargerType: .ac))
        }

        for station in dcStations {
            let coord = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
            annotations.append(StationAnnotation(station: station, coordinate: coord, title: station.stationName, chargerType: .dc))
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

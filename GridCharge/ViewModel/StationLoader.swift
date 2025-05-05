//
//  StationLoader.swift
//  GridCharge
//
//  Created by Michael Lam on 30/4/2025.
//

import Foundation

class StationLoader: ObservableObject {
    // @State but for ViewModel, the View will grab this
    @Published var stations: [ChargingStation] = []

    init() {
        load_ACStations()
//        load_DCStations()
//        load_UpcomingStations()
    }

    func load_ACStations() {
        guard let url = Bundle.main.url(forResource: "AC_Chargers", withExtension: "JSON") else {
            print("JSON not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([ChargingStation].self, from: data)
            self.stations = decoded
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    // FIXME: Require different Models due to different data for each Charger
    // - Create a new model for each / make it adaptable
//    func load_DCStations() {
//        guard let url = Bundle.main.url(forResource: "DC_Chargers", withExtension: "JSON") else {
//            print("JSON not found")
//            return
//        }
//
//        do {
//            let data = try Data(contentsOf: url)
//            let decoded = try JSONDecoder().decode([ChargingStation].self, from: data)
//            self.stations = decoded
//        } catch {
//            print("Error decoding JSON: \(error)")
//        }
//    }
//    
//    func load_UpcomingStations() {
//        guard let url = Bundle.main.url(forResource: "Upcoming_Chargers", withExtension: "JSON") else {
//            print("JSON not found")
//            return
//        }
//
//        do {
//            let data = try Data(contentsOf: url)
//            let decoded = try JSONDecoder().decode([ChargingStation].self, from: data)
//            self.stations = decoded
//        } catch {
//            print("Error decoding JSON: \(error)")
//        }
//    }
}

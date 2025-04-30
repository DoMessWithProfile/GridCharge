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
        loadStations()
    }

    func loadStations() {
        guard let url = Bundle.main.url(forResource: "AC_Chargers2", withExtension: "JSON") else {
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
}

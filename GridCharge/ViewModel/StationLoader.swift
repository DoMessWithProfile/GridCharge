//
//  StationLoader.swift
//  GridCharge
//
//  Created by Michael Lam on 30/4/2025.
//

import Foundation

/// Complete re-write for adaptablility of 4 types of stations

func loadACStations() -> [ChargingStation] {
    loadStations(from: "AC_Chargers")
}

func loadDCStations() -> [ChargingStation] {
    loadStations(from: "DC_Chargers")
}

private func loadStations(from fileName: String) -> [ChargingStation] {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "JSON") else {
        print("JSON not found: \(fileName)")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([ChargingStation].self, from: data)
    } catch {
        print("Error decoding in \(fileName): \(error)")
        return []
    }
}

func loadUpcomingStations() -> [UpcomingChargingStation] {
    guard let url = Bundle.main.url(forResource: "Upcoming_Chargers", withExtension: "JSON") else {
        print("JSON not found: Upcoming_Chargers")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([UpcomingChargingStation].self, from: data)
    } catch {
        print("Error decoding in Upcoming_Chargers: \(error)")
        return []
    }
}


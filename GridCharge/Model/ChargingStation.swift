//
//  ChargingStation.swift
//  GridCharge
//
//  Created by Michael Lam on 30/4/2025.
//

import Foundation

struct ChargingStation: Identifiable, Decodable {
    var id: Int { ObjId }
    
    // from JSON
    let ObjId: Int
    let stationName: String
    let stationAddress: String
    let openingHours: String
    let operatorName: String
    let numberOfStation: Int
    let numberOfPlugs: Int
    let chargerRating: String
    let latitude: Double
    let longitude: Double
    
    // AC Chargers
    let tesla: Int?
    let type2: Int?
    let j1772: Int?
    
    // DC Chargers
    struct CCS: Codable {
        let sae: Int

        enum CodingKeys: String, CodingKey {
            case sae = "SAE"
        }
    }
    
    let chademo: Int?
    let ccs: CCS?
    let teslaFast: Int?

    enum CodingKeys: String, CodingKey {
        case ObjId
        case stationName = "Station name"
        case stationAddress = "Station address"
        case openingHours = "Opening hours"
        case operatorName = "Operator"
        case numberOfStation = "Number of station"
        case numberOfPlugs = "Number of plugs"
        case chargerRating = "Charger rating"
        case latitude = "Latitude"
        case longitude = "Longitude"

        case tesla = "Tesla"
        case type2 = "Type 2"
        case j1772 = "J-1772"

        case chademo = "CHAdeMO"
        case ccs = "CCS"
        case teslaFast = "Tesla(Fast)"
    }
}

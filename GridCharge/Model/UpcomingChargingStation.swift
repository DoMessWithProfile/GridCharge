//
//  ChargingStation.swift
//  GridCharge
//
//  Created by Michael Lam on 5/5/2025.
//

import Foundation

struct UpcomingChargingStation: Identifiable, Decodable {
    var id: Int { ObjId }
    
    let ObjId: Int
    let siteAddress: String
    let applicant: String
    let chargingBays: Int
    let chargerCapacities: String
    let lat: Double
    let lng: Double

    enum CodingKeys: String, CodingKey {
        case ObjId
        case siteAddress = "Site Address"
        case applicant = "Applicant"
        case chargingBays = "Charging_bays"
        case chargerCapacities = "Charger_capacities"
        case lat
        case lng
    }
}

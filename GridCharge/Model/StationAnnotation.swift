//
//  StationAnnotation.swift
//  GridCharge
//
//  Created by Michael Lam on 1/5/2025.
//

import Foundation
import MapKit

//class StationAnnotation: MKPointAnnotation {
//    let station: ChargingStation
//
//    init(station: ChargingStation) {
//        self.station = station
//        super.init()
//        self.coordinate = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
//        self.title = station.stationName
//        self.subtitle = station.stationAddress
//    }
//}

enum ChargerType {
    case ac, dc, upcoming, community, tesla
}

// rewrite was done for adaptability of 4 types of chargers
class StationAnnotation: NSObject, MKAnnotation {
    let station: ChargingStation?
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let chargerType: ChargerType

    init(station: ChargingStation, coordinate: CLLocationCoordinate2D, title: String, chargerType: ChargerType) {
        self.station = station
        self.coordinate = coordinate
        self.title = title
        self.chargerType = chargerType
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String, chargerType: ChargerType) {
        station = nil
        self.coordinate = coordinate
        self.title = title
        self.chargerType = chargerType
    }
}


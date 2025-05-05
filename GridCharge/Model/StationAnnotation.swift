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
    case ac, dc, upcoming
}

// rewrite required for adaptability of 4 types of chargers
class StationAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let chargerType: ChargerType

    init(coordinate: CLLocationCoordinate2D, title: String, chargerType: ChargerType) {
        self.coordinate = coordinate
        self.title = title
        self.chargerType = chargerType
    }
}


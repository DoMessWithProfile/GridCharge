//
//  StationAnnotation.swift
//  GridCharge
//
//  Created by Michael Lam on 1/5/2025.
//

import Foundation
import MapKit

class StationAnnotation: MKPointAnnotation {
    let station: ChargingStation

    init(station: ChargingStation) {
        self.station = station
        super.init()
        self.coordinate = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
        self.title = station.stationName
        self.subtitle = station.stationAddress
    }
}

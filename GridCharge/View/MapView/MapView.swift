//
//  MapView.swift
//  GridCharge
//
//  Created by Michael Lam on 29/4/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // TODO: JSON file read
    
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.88393, longitude: 151.20051), latitudinalMeters: 0.1, longitudinalMeters: 0.1)
    
    var body: some View {
        Text("Map")
            .fontWeight(.bold)
        
        Map {
            Annotation("EVC 1", coordinate: .evc1) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.teal)
                    Image(systemName: "ev.charger")
                        .foregroundStyle(.regularMaterial)
                        .padding(10)
                }
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        
        // Neck Buttons
        HStack {
            Spacer()
            Image(systemName: "dollarsign.circle")
                .scaleEffect(2)
            Spacer()
            Image(systemName: "car")
                .scaleEffect(2)
            Spacer()
            Image(systemName: "house")
                .scaleEffect(2)
            Spacer()
            Image(systemName: "ev.charger")
                .scaleEffect(2)
            Spacer()
            Image(systemName: "map")
                .scaleEffect(2)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MapView()
}

extension CLLocationCoordinate2D {
    static let evc1 = CLLocationCoordinate2D(latitude: -33.88393, longitude: 151.20051)
}

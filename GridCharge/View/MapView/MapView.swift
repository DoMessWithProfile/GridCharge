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
        NavigationStack {
            ZStack {
                // Full-screen map and popups underneath
                TestView()
                
                VStack {
                    Spacer()
                    
                    // Navigation Buttons
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
                        NavigationLink(
                            destination: ChargingSessionView()) {
                                Image(systemName: "ev.charger")
                                    .scaleEffect(2)
                            }
                        Spacer()
                        Image(systemName: "map")
                            .scaleEffect(2)
                        Spacer()
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                }
                .ignoresSafeArea(edges: .horizontal) // Allows the buttons to sit on top
            }
        }
    }
}

#Preview {
    MapView()
}

extension CLLocationCoordinate2D {
    static let evc1 = CLLocationCoordinate2D(latitude: -33.88393, longitude: 151.20051)
}

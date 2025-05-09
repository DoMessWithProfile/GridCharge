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
    
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.88393, longitude: 151.20051), latitudinalMeters: 0.1, longitudinalMeters: 0.1)
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Full-screen map view
                TestView()
                    .edgesIgnoringSafeArea(.all)
                
            // Bottom Navigation Bar
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "dollarsign.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "car")
                            .font(.system(size: 24))
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "house")
                            .font(.system(size: 24))
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    NavigationLink(destination: ChargingSessionView()) {
                        Image(systemName: "ev.charger")
                            .font(.system(size: 24))
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "map")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .padding(.vertical, 15)
                .background(Color.white)
                .shadow(radius: 2, y: -3)
                }
                .edgesIgnoringSafeArea(.bottom)
                .zIndex(2) // Ensures navigation bar appears above all content
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    MapView()
}

extension CLLocationCoordinate2D {
    static let evc1 = CLLocationCoordinate2D(latitude: -33.88393, longitude: 151.20051)
}

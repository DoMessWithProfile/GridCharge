//
//  MapView.swift
//  GridCharge
//
//  Created by Michael Lam on 29/4/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var navigationViewModel = NavigationViewModel()
    
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.88393, longitude: 151.20051), latitudinalMeters: 0.1, longitudinalMeters: 0.1)
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Full-screen map view
                TestView()
                    .edgesIgnoringSafeArea(.all)
                
                // Bottom Navigation Bar
                NavigationView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(navigationViewModel)
        .onAppear {
            navigationViewModel.currentTab = .map
        }
    }
}
    
#Preview {
    MapView()
}

extension CLLocationCoordinate2D {
    static let evc1 = CLLocationCoordinate2D(latitude: -33.88393, longitude: 151.20051)
}

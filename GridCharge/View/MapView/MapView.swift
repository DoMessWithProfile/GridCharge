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
    
    //Creates a map region centered in Sydney
    var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -33.882635, longitude: 151.20061),
        latitudinalMeters: 0.1,
        longitudinalMeters: 0.1
    )
//defines the body of the MapView and
    //encompasses the main UI components of the screen
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Full-screen map view
                TestView()
                    .edgesIgnoringSafeArea(.all)
                
                // Bottom Navigation Bar
                NavigationView()
                    .environmentObject(navigationViewModel)
            }
            .onAppear {
                navigationViewModel.currentTab = .map
            }
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(navigationViewModel)
    }
}
//provides a preview for the user
#Preview {
    MapView()
}

extension CLLocationCoordinate2D {
    static let evc1 = CLLocationCoordinate2D(latitude: -33.88264, longitude: 151.20061)
}

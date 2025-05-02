//
//  TestView.swift
//  GridCharge
//
//  Created by Michael Lam on 30/4/2025.
//

import SwiftUI
import MapKit

struct TestView: View {
    @StateObject private var loader = StationLoader()
    @State private var selectedStation: ChargingStation? // Track selected station
    
    var body: some View {
        ZStack {
            ClusteredMapView(stations: loader.stations, selectedStation: $selectedStation)
                .edgesIgnoringSafeArea(.all)
            
            // Overlay popup when a station is selected
            if let station = selectedStation {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Dismiss when tapping outside
                        selectedStation = nil
                    }
                
                StationDetailPopup(station: station) {
                    // Close button action
                    selectedStation = nil
                }
                .transition(.scale)
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: selectedStation != nil)
    }
}

#Preview {
    TestView()
}

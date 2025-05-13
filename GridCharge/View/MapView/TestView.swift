//
//  TestView.swift
//  GridCharge
//
//  Created by Michael Lam on 30/4/2025.
//

import SwiftUI
import MapKit

struct TestView: View {
    @StateObject private var viewModel = StationViewModel()
    //Creates a view model
    @State private var selectedStation: ChargingStation? // Track selected station
    @State private var showTeslaOnly: Bool = false // Toggle for Tesla filter
    
    var body: some View {
        ZStack {
            // Filter stations based on Tesla availability when showTeslaOnly is true
            ClusteredMapView(selectedStation: $selectedStation, annotations: viewModel.createAnnotations(
                acStations: showTeslaOnly ? viewModel.acStations.filter { $0.tesla ?? 0 > 0 } : viewModel.acStations,
                dcStations: showTeslaOnly ? viewModel.dcStations.filter { $0.teslaFast ?? 0 > 0 } : viewModel.dcStations,
                upcomingStations: viewModel.upcomingStations,
                communityStations: viewModel.communityStations)
            )
            .edgesIgnoringSafeArea(.all)
            
            // Tesla filter toggle button
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showTeslaOnly.toggle()
                    }) {
                        HStack {
                            Image(systemName: "bolt.fill")
                                .foregroundColor(.red)
                            Text(showTeslaOnly ? "All Chargers" : "Tesla Only")
                                .fontWeight(.medium)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(
                            Capsule()
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        )
                    }
                    .padding(.trailing, 16)
                    .padding(.top, 100)
                }
                
                Spacer()
            }
            
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

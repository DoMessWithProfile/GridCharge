//
//  StationDetailPopup.swift
//  GridCharge
//
//  Created on 2/5/2025.
//

import SwiftUI
import MapKit
import UIKit

//old-to do: make everything within this struct able to resize dynamically. No hardcoded frame values! but then also ensure no other values are hardcoded, make it dynamic so that this can work on all types of devices

//All frame values are currently fixed

//TODO: Ensure font values are not hard-coded

struct NavigationAppButton: View {
    let appName: String
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                // Custom icon for app
                Group {
                    if UIImage(named: iconName) != nil {
                        Image(iconName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(appName)
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
            }
        }
    }
}
//displays specific details about a charging //station
struct StationDetailPopup: View {
    let station: ChargingStation
    var onClose: () -> Void
    @State private var showingActionSheet = false
    
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height

            
            VStack(alignment: .leading) {
                HStack {
                    Text(station.stationName)
                        .font(.headline)
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                
                Divider()
                
                Group {
                    DetailRow(icon: "location.fill", text: station.stationAddress)
                    DetailRow(icon: "clock", text: "Hours: \(station.openingHours)")
                    DetailRow(icon: "person.fill", text: "Operator: \(station.operatorName)")
                    
                    HStack() {
                        Spacer()
                        DetailBox(value: "\(station.numberOfStation)", label: "Stations")
                        Spacer()
                        DetailBox(value: "\(station.numberOfPlugs)", label: "Plugs")
                        Spacer()
                        DetailBox(value: station.chargerRating, label: "Rating")
                        Spacer()
                    }
//                    Spacer()
                    Text("Available Connectors:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
//                        .padding(.bottom)
                    HStack() {
                        //TODO: make these icons different
//                        Spacer()
                        ConnectorItem(count: station.tesla ?? 0, name: "Tesla", iconName: "bolt.circle")
//                        Spacer()
                        ConnectorItem(count: station.type2 ?? 0, name: "Type 2", iconName: "bolt.car")
//                        Spacer()
                        ConnectorItem(count: station.j1772 ?? 0, name: "J-1772", iconName: "car.circle")
//                        Spacer()
                        
                    }
                }
                
                Spacer()
                
                Button(action: {
                    showingActionSheet = true
                }) {
                    Text("Navigate")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showingActionSheet) {
                    VStack(spacing: 0) {
                        Text("Open In")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                            .padding(.bottom, 25)
                        
                        HStack(spacing: 40) {
                            NavigationAppButton(
                                appName: "Maps",
                                iconName: "Apple",
                                action: {
                                    showingActionSheet = false
                                    openInAppleMaps()
                                }
                            )
                            
                            NavigationAppButton(
                                appName: "Google Maps",
                                iconName: "Google",
                                action: {
                                    showingActionSheet = false
                                    openInGoogleMaps()
                                }
                            )
                            
                            NavigationAppButton(
                                appName: "Waze",
                                iconName: "Waze",
                                action: {
                                    showingActionSheet = false
                                    openInWaze()
                                }
                            )
                        }
                        .padding(.bottom)
                        
                        Divider()
                        
                        Button(action: {
                            // Placeholder - no action for now
                            showingActionSheet = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // Add delay to ensure sheet is dismissed
                                    shareStation() // Then present
                                }
                       
                        }) {
                            Text("Share")
                                .font(.title3)
                                .foregroundColor(.blue)
                                .padding()
                        }
                        
                        Divider()
                        
                        Button(action: {
                            showingActionSheet = false
                        }) {
                            Text("Cancel")
                                .font(.title3)
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                    .presentationDetents([.height(screenHeight * 0.34)])
                    .presentationDragIndicator(.visible)
                }
            }
            .padding()
            .frame(width: (screenWidth * 0.8), height: (screenHeight * 0.45))
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 10)
            //Middle horizontally, slightly higher than middle of the screen
            .position(x: (screenWidth / 2), y: (screenHeight / 2.3))
        }
    }


    
    // Function to open location in Apple Maps
    private func openInAppleMaps() {
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude))
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = station.stationName
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    // Function to open location in Google Maps
    private func openInGoogleMaps() {
        let urlString = "comgooglemaps://?daddr=\(station.latitude),\(station.longitude)&directionsmode=driving"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Google Maps is not installed, open in browser
                let googleUrl = "https://www.google.com/maps/dir/?api=1&destination=\(station.latitude),\(station.longitude)"
                if let webUrl = URL(string: googleUrl) {
                    UIApplication.shared.open(webUrl)
                }
            }
        }
    }
    
    // Function to open location in Waze
    private func openInWaze() {
        let urlString = "waze://?ll=\(station.latitude),\(station.longitude)&navigate=yes"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Waze is not installed, open in browser
                let webUrl = "https://www.waze.com/ul?ll=\(station.latitude)%2C\(station.longitude)&navigate=yes"
                if let wazeUrl = URL(string: webUrl) {
                    UIApplication.shared.open(wazeUrl)
                }
            }
        }
    }
    
    // Add this function inside the StationDetailPopup struct
    private func shareStation() {
        // Create the text to share
        let shareText = """
        Charging Station: \(station.stationName)
        Address: \(station.stationAddress)
        Hours: \(station.openingHours)
        Operator: \(station.operatorName)
        Location: https://maps.apple.com/?ll=\(station.latitude),\(station.longitude)&q=\(station.stationName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        """
        
        // Create the activity view controller
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        // Present the activity view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
    
}



// Helper views for the popup
struct DetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
//details two variables, a label and a //value, inside a box
struct DetailBox: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(minWidth: UIScreen.main.bounds.width * 0.15)
        .padding(.vertical, 8)
        .padding(.horizontal, 6)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
//shows a view for available connectors at a //station
struct ConnectorItem: View {
    let count: Int
    let name: String
    let iconName: String
    
    var body: some View {
        if count > 0 {
            VStack {
                Image(systemName: iconName)
                Text("\(count)x: \(name)")
                    .font(.caption)
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    // Mock data for preview
    StationDetailPopup(
        station: ChargingStation(
            ObjId: 1,
            stationName: "Central Charging Station",
            stationAddress: "123 Street, Central",
            openingHours: "24 hours",
            operatorName: "GridCharge",
            numberOfStation: 5,
            numberOfPlugs: 10,
            chargerRating: "50kW",
            latitude: 22.302711,
            longitude: 114.177216,
            tesla: 2,
            type2: 3,
            j1772: 5,
            chademo: 1,
            ccs: ChargingStation.CCS(sae:1),
            teslaFast: 1
        ),
        onClose: {}
    )
}

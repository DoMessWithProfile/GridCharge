//
//  StationDetailPopup.swift
//  GridCharge
//
//  Created on 2/5/2025.
//

import SwiftUI


//old-to do: make everything within this struct able to resize dynamically. No hardcoded frame values! but then also ensure no other values are hardcoded, make it dynamic so that this can work on all types of devices

//All frame values are currently fixed

//TODO: Ensure font values are not hard-coded

struct StationDetailPopup: View {
    let station: ChargingStation
    var onClose: () -> Void
    
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
                
                Text("Available Connectors:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                HStack() {
                    //TODO: make these icons different
                    Spacer()
                    // Old: count: station.tesla!, ...
                    // New: count: station.tesla ?? 0, ...
                    // safer way to unwrap optional, if nil then = 0
                    ConnectorItem(count: station.tesla ?? 0, name: "Tesla", iconName: "bolt.car")
                    Spacer()
                    ConnectorItem(count: station.type2 ?? 0, name: "Type 2", iconName: "bolt.car")
                    Spacer()
                    ConnectorItem(count: station.j1772 ?? 0, name: "J-1772", iconName: "bolt.car")
                    Spacer()
                    
                }
            }
            
            Spacer()
            
            Button(action: {
                // Action to navigate to this station,
                //TODO: for Ben to implement
            }) {
                Text("Navigate")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
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

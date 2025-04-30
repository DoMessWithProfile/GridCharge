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

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -28.5, longitude: 152.0),
            span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        )
    )

    var body: some View {
        Map(position: $position) {
            ForEach(loader.stations) { station in
                Annotation(
                    station.stationName,
                    coordinate: CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.teal)
                        Image(systemName: "ev.charger")
                            .foregroundStyle(.regularMaterial)
                            .padding(10)
                    }
                }
            }
        }
        .mapStyle(.standard)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    TestView()
}

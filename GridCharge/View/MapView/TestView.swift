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

    var body: some View {
        ClusteredMapView(stations: loader.stations)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    TestView()
}

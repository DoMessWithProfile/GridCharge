//
//  NavigationView.swift
//  GridCharge
//
//  Created by Benjamin Vu on 13/5/2025.
//

import SwiftUI

// Enum to track the current selected view
enum NavigationTab {
    case dollar, car, home, charging, map
}

// Create a view model to manage the current tab
class NavigationViewModel: ObservableObject {
    @Published var currentTab: NavigationTab = .home
}

struct NavigationView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    navigationViewModel.currentTab = .dollar
                }) {
                    Image(systemName: "dollarsign.circle")
                        .font(.system(size: 24))
                        .foregroundColor(navigationViewModel.currentTab == .dollar ? .blue : .primary)
                }
                Spacer()
                Button(action: {
                    navigationViewModel.currentTab = .car
                }) {
                    Image(systemName: "car")
                        .font(.system(size: 24))
                        .foregroundColor(navigationViewModel.currentTab == .car ? .blue : .primary)
                }
                Spacer()
                NavigationLink(destination: ContentView()) {
                    Image(systemName: "house")
                        .font(.system(size: 24))
                        .foregroundColor(navigationViewModel.currentTab == .home ? .blue : .primary)
                }
                Spacer()
                NavigationLink(destination: ChargingSessionView()) {
                    Image(systemName: "ev.charger")
                        .font(.system(size: 24))
                        .foregroundColor(navigationViewModel.currentTab == .charging ? .blue : .primary)
                }
                Spacer()
                NavigationLink(destination: MapView()) {
                    Image(systemName: "map")
                        .font(.system(size: 24))
                        .foregroundColor(navigationViewModel.currentTab == .map ? .blue : .primary)
                }
                Spacer()
            }
            .padding(.vertical, 15)
            .background(Color.white)
            .shadow(radius: 2, y: -3)
        }
        .edgesIgnoringSafeArea(.bottom)
        .zIndex(2)
    }
}

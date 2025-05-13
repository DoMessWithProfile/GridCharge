//
//  NavigationView.swift
//  GridCharge
//
//  Created by Benjamin Vu on 13/5/2025.
//

import SwiftUI

enum NavigationTab {
    case home, map, charging
}

class NavigationViewModel: ObservableObject {
    @Published var currentTab: NavigationTab = .home
}

struct NavigationView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @State private var isActiveHome = false
    @State private var isActiveMap = false
    @State private var isActiveCharging = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    if navigationViewModel.currentTab != .home {
                        navigationViewModel.currentTab = .home
                        isActiveHome = true
                    }
                }) {
                    Image(systemName: "house")
                        .font(.system(size: 24))
                        .foregroundColor(navigationViewModel.currentTab == .home ? .blue : .primary)
                }

                Spacer()
                Button(action: {
                    if navigationViewModel.currentTab != .map {
                        navigationViewModel.currentTab = .map
                        isActiveMap = true
                    }
                }) {
                    Image(systemName: "map")
                        .font(.system(size: 24))
                        .foregroundColor(navigationViewModel.currentTab == .map ? .blue : .primary)
                }

                Spacer()
                Button(action: {
                    if navigationViewModel.currentTab != .charging {
                        navigationViewModel.currentTab = .charging
                        isActiveCharging = true
                    }
                }) {
                    Image(systemName: "ev.charger")
                        .font(.system(size: 24))
                        .foregroundColor(navigationViewModel.currentTab == .charging ? .blue : .primary)
                }
                Spacer()
            }
            .padding(.vertical, 15)
            .background(Color.white)
            .shadow(radius: 2, y: -3)
        }
        .navigationDestination(isPresented: $isActiveHome) {
            ContentView()
        }
        .navigationDestination(isPresented: $isActiveMap) {
            MapView()
        }
        .navigationDestination(isPresented: $isActiveCharging) {
            ChargingSessionView()
        }
        .edgesIgnoringSafeArea(.bottom)
        .zIndex(2)
    }
}

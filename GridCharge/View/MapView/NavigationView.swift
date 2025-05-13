//
//  NavigationView.swift
//  GridCharge
//
//  Created by Benjamin Vu on 13/5/2025.
//

import SwiftUI

enum NavigationTab {
    case home, charging, map
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
                .background(
                    NavigationLink(destination: ContentView(), isActive: $isActiveHome) {
                        EmptyView()
                    }
                    .hidden()
                )

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
                .background(
                    NavigationLink(destination: MapView(), isActive: $isActiveMap) {
                        EmptyView()
                    }
                    .hidden()
                )

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
                .background(
                    NavigationLink(destination: ChargingSessionView(), isActive: $isActiveCharging) {
                        EmptyView()
                    }
                    .hidden()
                )
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

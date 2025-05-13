//
//  ChargingSessionView.swift
//  GridCharge
//
//  Created by Michael Lam on 27/4/2025.
//

import SwiftUI

struct ChargingSessionView: View {
    @StateObject private var navigationViewModel = NavigationViewModel()
    
    var body: some View {
        ZStack {
            // Main content in a VStack
            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer()
                    
                    Text("Charge")
                        .padding(.leading, 40)
                    
                    Spacer()
                    
                    Button {
                        // action
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.purple)
                    }
                    .scaleEffect(1.5)
                    .padding(.trailing)
                }
                .padding(.bottom, 8)
                
                // Tab section
                ZStack {
                    Rectangle()
                        .foregroundStyle(.regularMaterial)
                    HStack {
                        Spacer()
                        Button {
                            // action
                        } label: {
                            Text("SCHEDULE")
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        Text("NOW")
                        Spacer()
                        Text("HISTORY")
                        Spacer()
                    }
                }
                .frame(height: 80)
                
                // Main content area that expands to fill space
                VStack {
                    Spacer(minLength: 0)
                    SessionView()
                    Spacer(minLength: 0)
                    
                    // End session button
                    Button {
                        // action
                    } label: {
                        T_ButtonView(buttonText: "End Session")
                            .frame(width: 280, height: 80)
                    }
                    .padding(.bottom, 20)
                }
                
                // Empty space for the navigation bar
                Color.clear.frame(height: 60)
            }
            
            // Navigation bar at the bottom
            VStack {
                Spacer()
                NavigationView()
                    .environmentObject(navigationViewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(navigationViewModel)
        .onAppear {
            navigationViewModel.currentTab = .charging
        }
    }
}


#Preview {
    ChargingSessionView()
}

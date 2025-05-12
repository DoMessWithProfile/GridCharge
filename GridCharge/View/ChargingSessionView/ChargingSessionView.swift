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
            VStack {
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
                .frame(height: 100)
                
                Spacer()
                
                SessionView()
                
                Spacer()
                Spacer()
                
                Button {
                    // action
                } label: {
                    T_ButtonView(buttonText: "End Session")
                }
                Spacer()
                Spacer()
                Divider()
            }
            
            VStack {
                Spacer()
                NavigationView()
                    .environmentObject(navigationViewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            navigationViewModel.currentTab = .charging
        }
    }
}


#Preview {
    ChargingSessionView()
}

//
//  ChargingSessionView.swift
//  GridCharge
//
//  Created by Michael Lam on 27/4/2025.
//

import SwiftUI

struct ChargingSessionView: View {
    var body: some View {
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
            .frame(height: 80)
            Spacer()
            SessionView()
            Spacer()
            Button {
                // action
            } label: {
                T_ButtonView(buttonText: "End Session")
            }
            Divider()
        }
    }
}

#Preview {
    ChargingSessionView()
}

//
//  SessionView.swift
//  GridCharge
//
//  Created by Michael Lam on 27/4/2025.
//

import SwiftUI

struct SessionView: View {
    
    // TODO: implement timer
    @State var timeRemaining = "00:00:00"
    
    var body: some View {
        VStack {
            Text("Session active")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.purple)
                .padding(5)
            Text("This session is currently active, remember to end your session when you collect your vehicle.")
                .multilineTextAlignment(.center)
                .padding(5)
            Text("\(timeRemaining)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.purple)
                .padding(10)
            Image(systemName: "bolt.batteryblock.fill")
                .foregroundStyle(.purple)
                .scaleEffect(2)
                .padding(20)
        }
        .padding(30)
    }
}

#Preview {
    SessionView()
}

//
//  ContentView.swift
//  GridCharge
//
//  Created by Michael Lam on 22/4/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Text("GRIDCHARGE")
                .font(.largeTitle)
                .fontWeight(.bold)
            NavigationLink(destination: TestView()){
                T_ButtonView(buttonText: "A")
            }
            NavigationLink(destination: ContentView()){
                T_ButtonView(buttonText: "B")
            }
            NavigationLink(destination: ContentView()){
                T_ButtonView(buttonText: "C")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

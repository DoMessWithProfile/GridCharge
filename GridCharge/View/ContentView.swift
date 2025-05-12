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
            VStack(spacing: 20) {
                Image("GridChargeLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230, height: 100)
                
                NavigationLink(destination: MapView()) {
                    T_ButtonView(buttonText: "User")
                }
                
                NavigationLink(destination: ContentView()) {
                    T_ButtonView(buttonText: "Provider")
                }
                
                NavigationLink(destination: ContentView()) {
                    T_ButtonView(buttonText: "Coming Soon")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color(.purple)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarBackButtonHidden(true)
            .foregroundColor(.white)
        }
    }
}

struct SplashView: View {
    @State private var isActive = false
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                // Background from asset catalog
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Custom Logo with @2x asset
                    Image("GridChargeLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .clipShape(Rectangle())
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 3)) {
                                self.opacity = 1.0
                            }
                        }
                }
            }
            .onAppear {
                // Navigate to main content after delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

#Preview {
    SplashView()
}

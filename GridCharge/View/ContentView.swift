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
                T_ButtonView(buttonText: "User")
            }
            NavigationLink(destination: ContentView()){
                T_ButtonView(buttonText: "Provider")
            }
            NavigationLink(destination: ContentView()){
                T_ButtonView(buttonText: "C")
            }
            NavigationLink(destination:
                MapView()){
                T_ButtonView(buttonText: "I am a user")
            }
        }
        .padding()
    }
}

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var rotation = 0.0
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color(.cyan), Color(.magenta)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 150, height: 150)
                        
                        // Custom Logo
                        Image("GridChargeLogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2.5)) {
                            self.opacity = 1.0
                        }
                    }
                    
                    // App name
                    Text("GRIDCHARGE")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .opacity(opacity)
                        .animation(
                            Animation.easeIn(duration: 1.2),
                            value: opacity
                        )
                    
                    // Tagline
                    Text("Powering Your Drive Together")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 5)
                        .opacity(opacity)
                        .animation(
                            Animation.easeIn(duration: 1.2).delay(0.3),
                            value: opacity
                        )
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

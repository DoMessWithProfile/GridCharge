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
            GeometryReader { geometry in
                
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                
                VStack {
                    NavigationLink(destination: MapView()){
                        T_ButtonView(buttonText: "I'm a User", isDisabled: false)
                            .frame(width: (screenWidth * 0.8), height: (screenHeight * 0.15))
                    }
                    .padding(.bottom)
                    NavigationLink(destination: ContentView()){
                        T_ButtonView(buttonText: "I'm a Provider - Coming soon", isDisabled: true)
                            .frame(width: (screenWidth * 0.8), height: (screenHeight * 0.15))

                        
                    }.disabled(true)

                }
//                    .frame(width: (screenWidth * 0.8), height: (screenHeight * 0.45))
                .position(x: (screenWidth / 2.2), y: (screenHeight / 2))
                .padding()
            }
        }
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
//                        Circle()
//                            .fill(Color.black.opacity(0.1))
//                            .frame(width: 120, height: 120)
////
                        ///
                Text("GridCharge")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .opacity(opacity)
            .animation(
                Animation.easeIn(duration: 1.2),
                value: opacity
            )
                        // Custom Logo
                        
                        
                

                    }
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2.5)) {
                            self.opacity = 1.0
                        }
                    }
                
                    
                    // Tagline
                    Text("Powering your drive.")
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

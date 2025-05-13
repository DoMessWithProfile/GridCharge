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
                
                VStack(spacing: 20) {
                    Image("GridChargeLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 100)
                        .shadow(color: .white.opacity(0.3), radius: 8, x: 0, y: 0)
                    
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
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black, Color(.darkGray)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .navigationBarBackButtonHidden(true)
                .foregroundColor(.white)
            }
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
                // Custom Background
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Custom Logo
                    Image("GridChargeLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .clipShape(Rectangle())
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.5)) {
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

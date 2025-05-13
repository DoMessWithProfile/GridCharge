//
//  SplashView.swift
//  GridCharge
//
//  Created by joshua chelashaw on 13/5/2025.
//

import SwiftUI

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
                        .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 0)
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
    SplashView()
}

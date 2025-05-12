//
//  T_ButtonView.swift
//  GridCharge
//
//  Created by Michael Lam on 27/4/2025.
//

import SwiftUI

struct T_ButtonView: View {
    
    var buttonText : String = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 280, height: 80)
                .foregroundStyle(.purple)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 4)
            Text("\(buttonText)")
                .fontWeight(.heavy)
                .foregroundStyle(.regularMaterial)
        }
    }
}

#Preview {
    T_ButtonView(buttonText: "Hello World")
}

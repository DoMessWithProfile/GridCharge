//
//  T_ButtonView.swift
//  GridCharge
//
//  Created by Michael Lam on 27/4/2025.
//

import SwiftUI

struct T_ButtonView: View {
    var buttonText : String = ""
    var isDisabled : Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(isDisabled ? .gray : .purple)
            
            Text("\(buttonText)")
                .fontWeight(.heavy)
                .foregroundStyle(.regularMaterial)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    T_ButtonView(buttonText: "Hello World", isDisabled: false)
        .frame(width: 280, height: 80)
}

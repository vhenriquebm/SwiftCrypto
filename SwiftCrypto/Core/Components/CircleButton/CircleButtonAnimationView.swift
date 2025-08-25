//
//  CircleButtonAnimationView.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 25/08/2025.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut : .default, value: animate)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
}

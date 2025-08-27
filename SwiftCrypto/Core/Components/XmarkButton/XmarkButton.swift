//
//  XmarkButton.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 27/08/2025.
//

import SwiftUI

struct XmarkButton: View {
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

#Preview {
    XmarkButton()
}

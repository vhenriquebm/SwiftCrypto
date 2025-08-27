//
//  UIAplication+.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 27/08/2025.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//
//  HapticManager.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 29/08/2025.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

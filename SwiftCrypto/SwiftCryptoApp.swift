//
//  SwiftCryptoApp.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 25/08/2025.
//

import SwiftUI

@main
struct SwiftCryptoApp: App {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}

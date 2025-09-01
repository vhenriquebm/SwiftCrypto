//
//  DetailView.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 01/09/2025.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}

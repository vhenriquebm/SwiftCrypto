//
//  DetailViewModel.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 01/09/2025.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private let coinDetailService: CoinDetailService
    private var cancellabes = Set<AnyCancellable>()
    private var coin: CoinModel
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailService(coin: coin)
        self.coin = coin
        self.addSubcribers()
    }
    
    private func addSubcribers() {
        coinDetailService.$coinDetails
            .sink { (returnedCoinDetails) in
                print(returnedCoinDetails)
            }
            .store(in: &cancellabes)
    }
}

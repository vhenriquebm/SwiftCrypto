//
//  HomeViewModel.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 25/08/2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$coins.sink { [weak self] coins in
            self?.allCoins = coins
        }
        .store(in: &cancellables)
    }
}

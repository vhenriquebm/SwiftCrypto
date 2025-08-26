//
//  CoinDataService.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 26/08/2025.
//


//
//  CoinDataService.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 26/08/2025.
//

import Foundation
import Combine

final class CoinDataService: ObservableObject {
    
    @Published var coins: [CoinModel] = []
    private var cancellables = Set<AnyCancellable>()
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        let urlString =
        "https://api.coingecko.com/api/v3/coins/markets" +
        "?vs_currency=usd&order=market_cap_desc&per_page=250&page=1" +
        "&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [ weak self ] returnedCoins in
                self?.coins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}


//
//  DetailService.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 01/09/2025.
//

import Foundation
import Combine

final class CoinDetailService: ObservableObject {
    
    @Published var coinDetails: CoinDetailModel? = nil
    private var cancellables = Set<AnyCancellable>()
    var coinDetailSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinsDetails()
    }
    
    func getCoinsDetails() {
        let urlString =
        "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        
        guard let url = URL(string: urlString) else { return }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [ weak self ] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}

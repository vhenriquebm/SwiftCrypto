//
//  MarketDataService.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 27/08/2025.
//

import Foundation
import Combine

final class MarketDataService: ObservableObject {
    
    @Published var marketData: MarketDataModel? = nil
    
    private var cancellables = Set<AnyCancellable>()
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }

    func getData() {
        let urlString =
        "https://api.coingecko.com/api/v3/global"
        
        guard let url = URL(string: urlString) else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [ weak self ] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}

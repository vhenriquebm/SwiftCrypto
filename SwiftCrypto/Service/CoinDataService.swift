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

enum ApiError: Error {
    case invalidURL
    case decodingError
    case networkingError(Error)
}

final class CoinDataService: ObservableObject {
    
    @Published var coins: [CoinModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        let urlString =
        "https://api.coingecko.com/api/v3/coins/markets" +
        "?vs_currency=usd&order=market_cap_desc&per_page=250&page=1" +
        "&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else {
            print(ApiError.invalidURL)
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Error:", error)
                    }
                },
                receiveValue: { [weak self] returnedCoins in
                    self?.coins = returnedCoins
                }
            )
            .store(in: &cancellables)
    }
}


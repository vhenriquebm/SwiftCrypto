//
//  PreviewProvider.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 25/08/2025.
//

import SwiftUI

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() {}
    
    let homeViewModel = HomeViewModel()
    
    let coin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        currentPrice: 65000,
        marketCap: 1200000000000,
        marketCapRank: 1,
        fullyDilutedValuation: 1300000000000,
        totalVolume: 35000000000,
        high24H: 65500,
        low24H: 64000,
        priceChange24H: -500,
        priceChangePercentage24H: -0.75,
        marketCapChange24H: -10000000000,
        marketCapChangePercentage24H: -0.82,
        circulatingSupply: 19500000,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 69000,
        athChangePercentage: -5.8,
        athDate: "2021-11-10T14:24:11.849Z",
        atl: 67.81,
        atlChangePercentage: 95600,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2025-08-25T18:00:00.000Z",
        sparklineIn7D: SparklineIn7D(
            price: [64000, 64200, 64500, 65000, 65200, 64800, 64600, 64900, 65100]
        ),
        priceChangePercentage24HInCurrency: -0.75,
        currentHoldings: 1.5
    )
}


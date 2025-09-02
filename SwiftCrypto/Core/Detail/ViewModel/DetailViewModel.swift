//
//  DetailViewModel.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 01/09/2025.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var coin: CoinModel
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    
    private let coinDetailService: CoinDetailService
    private var cancellabes = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailService(coin: coin)
        self.coin = coin
        self.addSubcribers()
    }
    
    private func addSubcribers() {
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataStatistics)
            .sink { [ weak self ] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellabes)
    }
    
    private func mapDataStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        
        let overviewArray = createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let priceChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: priceChange)
        
        let marketCap = coinModel.marketCap?.formattedWithAbbreviations() ?? ""
        let marketCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
        
        let rank = "\(self.coin.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [priceStat, marketCapStat, rankStat, volumeStat]
        
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        
        let high = self.coin.high24H?.asCurrencyWith6Decimals() ?? ""
        let highsStat = StatisticModel(title: "24h High", value: high)
        
        let low = self.coin.low24H?.asCurrencyWith6Decimals() ?? ""
        let lowsStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange2 = coinModel.priceChange24H?.asCurrencyWith6Decimals()
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change",
                                             value: priceChange2 ?? "" ,
                                             percentageChange: pricePercentChange2 ?? 0)
        
        let marketCapChange2 = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change",
                                                 value: marketCapChange2, percentageChange: marketCapPercentChange2)
        
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime) minutes"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? ""
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [highsStat, lowsStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
        
        return additionalArray
    }
}

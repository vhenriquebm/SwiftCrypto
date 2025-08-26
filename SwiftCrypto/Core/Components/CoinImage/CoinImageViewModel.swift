//
//  CoinImageViewModel.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 26/08/2025.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables: Set<AnyCancellable> = []
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image.sink { [weak self] image in
            self?.isLoading = false
        } receiveValue: { [ weak self ](returnedImage) in
            self?.image = returnedImage
        }
        .store(in: &cancellables)
    }
}

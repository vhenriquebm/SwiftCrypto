//
//  CoinImageService.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 26/08/2025.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init (coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName,
                                                 folderName: folderName) {
            image = savedImage
            
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap { data -> UIImage in
                guard let img = UIImage(data: data) else {
                    throw URLError(.cannotDecodeContentData)
                }
                return img
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedImage in
                    guard let self = self else { return }
                    self.image = returnedImage
                    self.imageSubscription?.cancel()
                    self.fileManager.saveImage(
                        image: returnedImage,
                        imageName: self.imageName,
                        folderName: self.folderName
                    )
                }
            )
    }
}

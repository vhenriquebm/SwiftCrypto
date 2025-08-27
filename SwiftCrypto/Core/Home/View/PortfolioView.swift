//
//  PortfolioView.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 27/08/2025.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    coinLogoList
                    
                    if selectCoin != nil {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Current price of \(selectCoin?.symbol.uppercased() ?? ""):")
                                Spacer()
                                Text(selectCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Amount in your portfolios")
                                Spacer()
                                TextField("Ex: 1.4", text: $quantityText)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Current value:")
                                Spacer()
                                Text(getCurrentValue().asCurrencyWith2Decimals())
                            }
                        }
                        .animation(.none, value: 0)
                    }
                    
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeViewModel)
}



extension PortfolioView {
    
    var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10).stroke(selectCoin?.id == coin.id ? Color.green : Color.clear, lineWidth: 1)
                            
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        })
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectCoin?.currentPrice ?? 0)
        }
        return 0
    }
}

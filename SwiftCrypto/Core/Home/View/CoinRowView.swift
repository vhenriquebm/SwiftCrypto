//
//  CoinRowView.swift
//  SwiftCrypto
//
//  Created by MARINHO Vitor on 25/08/2025.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            }
            
            rightColumn
            
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin:DeveloperPreview.instance.coin, showHoldingsColumn: true)
}

#Preview(traits: .sizeThatFitsLayout) {
    
    CoinRowView(coin:DeveloperPreview.instance.coin, showHoldingsColumn: true)
        .preferredColorScheme(.dark)
}


extension CoinRowView {
    
    var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width:30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith6Decimals())
                .bold()
            Text((coin.currentHoldings)?.asNumberString() ?? "0.00")
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    var rightColumn: some View {
        
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(
                    
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green :
                        Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

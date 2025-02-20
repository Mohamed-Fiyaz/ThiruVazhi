//
//  HistoryCard.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 14/02/25.
//

import SwiftUI

struct HistoryCard: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Binding var historyScrollProxy: ScrollViewProxy?

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3  
        }
        return size
    }

    
    var body: some View {
            VStack(alignment: .center, spacing: 16) {
                Text("History of Thirukkural")
                    .font(.system(size: fontSize(22)))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                VStack(spacing: 12) {
                    Text("Thirukkural, written by the revered poet Thiruvalluvar over 2,000 years ago, is a timeless Tamil classic. Comprising 1,330 couplets, it offers wisdom on virtue, wealth, and love. Its universal values have made it a cornerstone of ethics and morality.")
                        .font(.system(size: fontSize(16)))
                        .foregroundColor(.black)
                        .padding(20)
                    NavigationLink(destination: HistoryDetailView(scrollProxy: $historyScrollProxy)) {

                    Text("Read More")
                        .font(.system(size: fontSize(16)))
                        .fontWeight(.medium)
                        .foregroundColor(AppColors.primaryRed)
                        .padding(.bottom, 12)
                }

            }
                .background(AppColors.cardBg)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.cardStroke, lineWidth: 1)
                )
        }
    }
}

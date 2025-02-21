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
                Text("Thirukkural, authored by Thiruvalluvar over 2,000 years ago, is one of the greatest literary works in Tamil. Consisting of 1,330 couplets, it is divided into three sections—Virtue (Aram), Wealth (Porul), and Love (Inbam). Each couplet, written in just seven words, conveys profound wisdom, making it a masterpiece of brevity and depth in classical literature.")
                    .font(.system(size: fontSize(16)))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .padding(20)
                    .lineSpacing(6)
                NavigationLink(destination: HistoryDetailView(scrollProxy: $historyScrollProxy)) {
                    
                    Text("Read More")
                        .font(.system(size: fontSize(16)))
                        .fontWeight(.medium)
                        .foregroundColor(AppColors.primaryRed)
                        .padding(.bottom, 12)
                }
                
            }
            .padding()
            .background(AppColors.cardBg)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColors.cardStroke, lineWidth: 1)
            )
        }
    }
}

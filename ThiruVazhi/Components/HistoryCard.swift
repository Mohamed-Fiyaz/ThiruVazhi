//
//  HistoryCard.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 14/02/25.
//

import SwiftUI

struct HistoryCard: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    private func fontSize(_ size: CGFloat) -> CGFloat {
        sizeClass == .regular ? size * 1.3 : size
    }
    
    var body: some View {
            VStack(alignment: .center, spacing: 16) {
                Text("History of Thirukkural")
                    .font(.system(size: fontSize(22)))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                VStack(spacing: 12) {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                        .font(.system(size: fontSize(16)))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(20)
                    NavigationLink(destination: HistoryDetailView()) {

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

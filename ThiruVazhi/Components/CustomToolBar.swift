//
//  CustomToolBar.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation
import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabBarButton(imageName: "house", title: "Home", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            TabBarButton(imageName: "book", title: "Chapters", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            TabBarButton(imageName: "magnifyingglass", title: "Explore", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
            TabBarButton(imageName: "star", title: "Favorites", isSelected: selectedTab == 3) {
                selectedTab = 3
            }
        }
        .padding(.vertical, 8)
        .background(AppColors.primaryRed)
    }
}

struct TabBarButton: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: imageName)
                    .foregroundColor(isSelected ? AppColors.goldText : .gray)
                Text(title)
                    .font(.caption)
                    .foregroundColor(isSelected ? AppColors.goldText : .gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

//
//  CustomToolBar.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    var onRepeatTap: (Int) -> Void
    
    var body: some View {
        HStack {
            TabBarButton(imageName: "house", title: "Home", isSelected: selectedTab == 0) {
                if selectedTab == 0 {
                    onRepeatTap(0)
                } else {
                    selectedTab = 0
                }
            }
            TabBarButton(imageName: "book", title: "Chapters", isSelected: selectedTab == 1) {
                if selectedTab == 1 {
                    onRepeatTap(1)
                } else {
                    selectedTab = 1
                }
            }
            TabBarButton(imageName: "magnifyingglass", title: "Explore", isSelected: selectedTab == 2) {
                if selectedTab == 2 {
                    onRepeatTap(2)
                } else {
                    selectedTab = 2
                }
            }
            TabBarButton(imageName: "star", title: "Favorites", isSelected: selectedTab == 3) {
                if selectedTab == 3 {
                    onRepeatTap(3)
                } else {
                    selectedTab = 3
                }
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
    
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    private var iconSize: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 24 : 20
    }
    
    private var textSize: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 14 : 12
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: imageName)
                    .font(.system(size: iconSize))
                    .foregroundColor(isSelected ? AppColors.goldText : .gray)
                    .animation(.easeInOut(duration: 0.1), value: isSelected)
                Text(title)
                    .font(.system(size: textSize))
                    .foregroundColor(isSelected ? AppColors.goldText : .gray)
                    .animation(.easeInOut(duration: 0.1), value: isSelected)
            }
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(TabBarButtonStyle())
    }
}

struct TabBarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

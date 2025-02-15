//
//  ContentView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ThirukkuralViewModel()
    @StateObject private var favoriteManager = FavoriteManager()
    @State private var selectedTab = 0
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3  // Scale only for iPads
        }
        return size
    }

    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("ThiruVazhi")
                    .font(.custom("PatrickHand-Regular", size: fontSize(36)))
                    .foregroundColor(AppColors.goldText)
                    .padding()
                Spacer()
            }
            .background(AppColors.primaryRed)
            
            TabView(selection: $selectedTab) {
                HomeView(viewModel: viewModel, favoriteManager: favoriteManager)
                    .tag(0)
                ChaptersView(viewModel: viewModel, favoriteManager: favoriteManager)
                    .tag(1)
                ExploreView(viewModel: viewModel, favoriteManager: favoriteManager)
                    .tag(2)
                FavoritesView(viewModel: viewModel, favoriteManager: favoriteManager)
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear {
                  UIScrollView.appearance().isScrollEnabled = false
            }
            CustomTabBar(selectedTab: $selectedTab)
        }
        .preferredColorScheme(.light)
        .background(AppColors.primaryBG)
    }
}

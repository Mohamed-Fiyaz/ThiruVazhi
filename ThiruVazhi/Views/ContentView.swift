//
//  ContentView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

// Update ContentView to ensure light mode
struct ContentView: View {
    @StateObject private var viewModel = ThirukkuralViewModel()
    @StateObject private var favoriteManager = FavoriteManager()
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation Bar
            HStack {
                Spacer()
                Text("ThiruVazhi")
                    .font(.custom("PatrickHand-Regular", size: 36))
                    .foregroundColor(AppColors.goldText)
                    .padding()
                Spacer()
            }
            .background(AppColors.primaryRed)
            
            // Content
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
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .preferredColorScheme(.light)
    }
}

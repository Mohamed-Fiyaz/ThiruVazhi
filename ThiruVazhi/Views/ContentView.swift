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
    
    @State private var homeScrollProxy: ScrollViewProxy? = nil
    @State private var chaptersScrollProxy: ScrollViewProxy? = nil
    @State private var exploreScrollProxy: ScrollViewProxy? = nil
    @State private var favoritesScrollProxy: ScrollViewProxy? = nil

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3
        }
        return size
    }
    
    private func handleRepeatTap(_ tab: Int) {
        switch tab {
        case 0:
            withAnimation(.easeInOut(duration: 0.5)) {
                homeScrollProxy?.scrollTo("top", anchor: .top)
            }
        case 1:
            withAnimation(.easeInOut(duration: 0.5)) {
                chaptersScrollProxy?.scrollTo("top", anchor: .top)
            }
        case 2:
            withAnimation(.easeInOut(duration: 0.5)) {
                exploreScrollProxy?.scrollTo("top", anchor: .top)
            }
        case 3:
            withAnimation(.easeInOut(duration: 0.5)) {
                favoritesScrollProxy?.scrollTo("top", anchor: .top)
            }
        default:
            break
        }
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
                HomeView(viewModel: viewModel,
                         favoriteManager: favoriteManager,
                         scrollProxy: $homeScrollProxy)
                    .tag(0)
                ChaptersView(viewModel: viewModel,
                             favoriteManager: favoriteManager,
                             scrollProxy: $chaptersScrollProxy)
                    .tag(1)
                ExploreView(viewModel: viewModel,
                            favoriteManager: favoriteManager,
                            scrollProxy: $exploreScrollProxy)
                    .tag(2)
                FavoritesView(viewModel: viewModel,
                              favoriteManager: favoriteManager,
                              scrollProxy: $favoritesScrollProxy)
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear {
                  UIScrollView.appearance().isScrollEnabled = false
            }
            CustomTabBar(selectedTab: $selectedTab, onRepeatTap: handleRepeatTap)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .preferredColorScheme(.light)
        .background(AppColors.primaryBG)
    }
}

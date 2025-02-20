//
//  HomeView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ThirukkuralViewModel
    @ObservedObject var favoriteManager: FavoriteManager
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Binding var scrollProxy: ScrollViewProxy?

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3
        }
        return size
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Show Tamil Text")
                        .font(.system(size: fontSize(17)))
                    Toggle("Show Tamil Text", isOn: $viewModel.showTamilText)
                        .labelsHidden()
                        .tint(AppColors.primaryRed)
                        .font(.system(size: fontSize(17)))
                }
                .padding()
                ScrollView {
                    ScrollViewReader { proxy in
                        VStack(spacing: 20) {
                            Color.clear.frame(height: 0).id("top")
                            
                            if let kuralOfDay = viewModel.kuralOfTheDay {
                                Text("Thirukkural of the day")
                                    .font(.system(size: fontSize(22)))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                KuralCard(kural: kuralOfDay,
                                        showTamilText: viewModel.showTamilText,
                                        favoriteManager: favoriteManager,
                                        viewModel: viewModel,
                                        hideChapterInfo: false)
                                .padding(.bottom, 20)

                            }
                            
                            if let randomKural = viewModel.randomKural {
                                Text("Random Thirukkural")
                                    .font(.system(size: fontSize(22)))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                KuralCard(kural: randomKural,
                                        showTamilText: viewModel.showTamilText,
                                        favoriteManager: favoriteManager,
                                        viewModel: viewModel,
                                        hideChapterInfo: false)

                                Button(action: {
                                    viewModel.generateRandomKural()
                                }) {
                                    Text("Generate New Thirukkural")
                                        .font(.system(size: fontSize(16)))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(AppColors.primaryRed)
                                        .cornerRadius(10)
                                }
                                .padding(.bottom, 20)
                            }
                            
                            HistoryCard(historyScrollProxy: $scrollProxy)

                        }
                        .padding()
                        .onAppear {
                            scrollProxy = proxy
                        }
                    }
                }
            }
            .background(AppColors.primaryBG)
            .navigationBarHidden(true)
        }
    }
}

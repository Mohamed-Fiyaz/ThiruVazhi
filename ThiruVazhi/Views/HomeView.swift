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

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3  // Scale only for iPads
        }
        return size
    }

    
    var body: some View {
        NavigationView {  // Add this NavigationView wrapper
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Show Tamil Text")
                    Toggle("Show Tamil Text", isOn: $viewModel.showTamilText)
                        .labelsHidden()
                        .tint(AppColors.primaryRed)
                }
                .padding()
                ScrollView {
                    VStack(spacing: 20) {
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
                        
                        HistoryCard()

                    }
                    .padding()
                }
            }
            .background(AppColors.primaryBG)
            .navigationBarHidden(true)
        }
    }
}

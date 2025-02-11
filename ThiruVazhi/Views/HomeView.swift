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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Text("Show Tamil Text")
                    Toggle("Show Tamil Text", isOn: $viewModel.showTamilText)
                        .labelsHidden()
                        .tint(AppColors.primaryRed)
                }
                
                if let kuralOfDay = viewModel.kuralOfTheDay {
                    Text("Thirukkural of the day")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    KuralCard(kural: kuralOfDay, showTamilText: viewModel.showTamilText, favoriteManager: favoriteManager, viewModel: viewModel, hideChapterInfo: false)
                }
                
                if let randomKural = viewModel.randomKural {
                    Text("Random Thirukkural")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    KuralCard(kural: randomKural, showTamilText: viewModel.showTamilText, favoriteManager: favoriteManager, viewModel: viewModel, hideChapterInfo: false)
                }
                
                Button(action: {
                    viewModel.generateRandomKural()
                }) {
                    Text("Generate New Thirukkural")
                        .foregroundColor(.white)
                        .padding()
                        .background(AppColors.primaryRed)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

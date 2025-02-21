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
    @State private var selectedHistory: Bool = false
    @State private var scrollID = UUID()
    
    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3
        }
        return size
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if selectedHistory {
                HStack {
                    Button(action: {
                        scrollID = UUID()
                        selectedHistory = false
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: fontSize(17)))
                            Text("Back")
                                .font(.system(size: fontSize(17)))
                        }
                        .foregroundColor(AppColors.primaryRed)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                .padding(.vertical, 12)
                
                HistoryDetailView(scrollProxy: $scrollProxy)
                    .id("history-\(scrollID.uuidString)")
            } else {
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
                            
                            Button(action: {
                                scrollID = UUID()
                                selectedHistory = true
                            }) {
                                HistoryCard(historyScrollProxy: $scrollProxy)
                            }
                        }
                        .padding()
                        .onAppear {
                            scrollProxy = proxy
                        }
                    }
                }
            }
        }
        .background(AppColors.primaryBG)
    }
}

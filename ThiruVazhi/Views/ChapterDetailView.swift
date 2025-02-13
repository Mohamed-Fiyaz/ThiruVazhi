//
//  ChapterDetailView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct ChapterDetailView: View {
    let chapter: Chapter
    @ObservedObject var viewModel: ThirukkuralViewModel
    @ObservedObject var favoriteManager: FavoriteManager
    @Environment(\.presentationMode) var presentationMode
    
    var chapterKurals: [Kural] {
        viewModel.kurals.filter { $0.Number >= chapter.start && $0.Number <= chapter.end }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(AppColors.primaryRed)
                }
                .padding(.leading)
                    .foregroundColor(.black)
                    HStack {
                        Spacer()
                        Text("Show Tamil Text")
                        Toggle("Show Tamil Text", isOn: $viewModel.showTamilText)
                            .labelsHidden()
                            .tint(AppColors.primaryRed)
                    }
                    .foregroundColor(.black)

                Spacer()
            }
            .padding(.vertical, 12)
            
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        if viewModel.showTamilText {
                            Text(chapter.name)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        Text(chapter.translation)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Chapter \(chapter.number)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        ForEach(chapterKurals) { kural in
                            KuralCard(kural: kural,
                                    showTamilText: viewModel.showTamilText,
                                    favoriteManager: favoriteManager,
                                    viewModel: viewModel,
                                    hideChapterInfo: true)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
        .navigationBarHidden(true)
        .background(AppColors.primaryBG)
    }
}

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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Binding var scrollProxy: ScrollViewProxy?
    @State private var scrollID = UUID()

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3  
        }
        return size
    }

    
    var chapterKurals: [Kural] {
        viewModel.kurals.filter { $0.Number >= chapter.start && $0.Number <= chapter.end }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    scrollID = UUID()
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
                
                Text("Show Tamil Text")
                    .font(.system(size: fontSize(17)))
                Toggle("Show Tamil Text", isOn: $viewModel.showTamilText)
                    .labelsHidden()
                    .tint(AppColors.primaryRed)
                    .padding(.trailing)
                    .font(.system(size: fontSize(17)))
            }
            .padding(.vertical, 12)
            
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(spacing: 16) {
                        Color.clear.frame(height: 0).id("top")
                        
                        VStack(alignment: .leading, spacing: 8) {
                            if viewModel.showTamilText {
                                Text(chapter.name)
                                    .font(.system(size: fontSize(22)))
                                    .fontWeight(.bold)
                            }
                            Text(chapter.translation)
                                .font(.system(size: fontSize(15)))
                                .foregroundColor(.secondary)
                            Text("Chapter \(chapter.number)")
                                .font(.system(size: fontSize(12)))
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
                    .onAppear {
                        scrollProxy = proxy
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .background(AppColors.primaryBG)
    }
}

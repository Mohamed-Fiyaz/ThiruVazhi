//
//  ChaptersView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation
import SwiftUI

struct ChaptersView: View {
    @ObservedObject var viewModel: ThirukkuralViewModel
    @ObservedObject var favoriteManager: FavoriteManager
    @State private var selectedBook = "Virtue"
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Select a Book")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 20)
            
            // Book selection buttons
            HStack(spacing: 12) {
                ForEach(["Virtue", "Wealth", "Love"], id: \.self) { book in
                    Button(action: { selectedBook = book }) {
                        Text(book)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedBook == book ? AppColors.primaryRed : Color.clear)
                            .foregroundColor(selectedBook == book ? .white : .primary)
                            .cornerRadius(20)
                    }
                }
            }
            
            SearchBar(text: .constant(""))
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(1...4, id: \.self) { index in
                        VStack {
                            Text("Chapter \(index)")
                                .font(.headline)
                            if index % 2 == 0 {
                                Text("On the Necessity of rain for life")
                            } else {
                                Text("The Praise of God")
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(AppColors.cardBg)
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}

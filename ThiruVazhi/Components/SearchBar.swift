//
//  SearchBar.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let onSearch: (String) -> Void
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isFocused)
                .onChange(of: text) { newValue in
                    onSearch(newValue)
                }
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onSearch("")
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .gesture(
            TapGesture()
                .onEnded { _ in
                    isFocused = false
                }
        )
    }
}

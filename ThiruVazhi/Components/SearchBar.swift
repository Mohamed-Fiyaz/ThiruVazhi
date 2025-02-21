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
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                
                TextField("Search", text: $text)
                    .focused($isFocused)
                    .onChange(of: text) { oldValue, newValue in
                        onSearch(newValue)
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        DispatchQueue.main.async {
                            text = ""
                            onSearch("")
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                    
                }
            }
            .padding(.vertical, 8)
            .background(Color(.white))
            .cornerRadius(10)
            
            if isFocused {
                Button("Cancel") {
                    text = ""
                    isFocused = false
                    onSearch("")
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil, from: nil, for: nil)
                }
                .foregroundColor(AppColors.primaryRed)
            }
        }
    }
}

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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3
        }
        return size
    }
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search", text: $text)
                    .focused($isFocused)
                    .font(.system(size: fontSize(18)))
                    .padding(.horizontal)
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
                .font(.system(size: fontSize(18)))
                .foregroundColor(AppColors.primaryRed)
            }
        }
    }
}

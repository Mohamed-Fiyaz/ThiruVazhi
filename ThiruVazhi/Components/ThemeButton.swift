//
//  ThemeButton.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct ThemeButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3  
        }
        return size
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: fontSize(24)))
                    .foregroundColor(AppColors.primaryRed)
                    .frame(height: 30)
                
                Text(title)
                    .font(.system(size: fontSize(14)))
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(height: 40)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100) 
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(
                        color: Color.black.opacity(0.1),
                        radius: 4,
                        x: 0,
                        y: 2
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColors.cardStroke.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity)
    }
}

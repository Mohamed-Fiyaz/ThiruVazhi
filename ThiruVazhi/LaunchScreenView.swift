//
//  LaunchScreen.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct LaunchScreenView: View {
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("ThiruVazhi")
                .font(.custom("PatrickHand-Regular", size: 48))
                .foregroundColor(AppColors.goldText)
            Spacer()
            Text("Made by Mohamed Fiyaz")
                .font(.system(size: 16))
                .foregroundColor(AppColors.goldText)
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.primaryRed)
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                isActive = true
            }
        }
    }
}


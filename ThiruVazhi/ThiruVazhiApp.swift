//
//  ThiruVazhiApp.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

@main
struct ThiruVazhiApp: App {
    @State private var isActive = false

    var body: some Scene {
        WindowGroup {
            if isActive {
                ContentView()
                    .preferredColorScheme(.light)
                    .navigationViewStyle(StackNavigationViewStyle())
            } else {
                LaunchScreenView(isActive: $isActive)
            }
        }
    }
}

//
//  ThiruVazhiApp.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI
import CoreText

@main
struct ThiruVazhiApp: App {
    @State private var isActive = false
    
    init() {
        registerCustomFont()
    }
    
    private func registerCustomFont() {
        guard let fontURL = Bundle.main.url(forResource: "PatrickHand-Regular", withExtension: "ttf") else {
            print("Failed to find PatrickHand-Regular font file")
            return
        }
        
        var error: Unmanaged<CFError>?
        
        if !CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error) {
            print("Error registering font: \(error?.takeRetainedValue().localizedDescription ?? "unknown error")")
        } else {
            print("Successfully registered PatrickHand-Regular font")
        }
    }
    
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

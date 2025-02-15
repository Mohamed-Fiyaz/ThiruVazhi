//
//  HistoryDetailView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 14/02/25.
//

import SwiftUI

struct HistoryDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3  // Scale only for iPads
        }
        return size
    }

    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar
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
                
                Spacer()
            }
            .padding(.vertical, 12)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("History of Thirukkural")
                        .font(.system(size: fontSize(22)))
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        historySection(
                            title: "Origins",
                            content: "The Thirukkural, written by Thiruvalluvar, is an ancient Tamil text dating back to between 3rd century BCE and 1st century CE. This masterpiece consists of 1,330 couplets (kurals) organized into 133 chapters of 10 couplets each."
                        )
                        
                        historySection(
                            title: "Structure and Content",
                            content: "The work is divided into three major sections: Virtue (Aram), Wealth (Porul), and Love (Inbam). Each section delves deep into various aspects of human life, providing guidance on ethics, politics, economics, and love."
                        )
                        
                        historySection(
                            title: "Cultural Impact",
                            content: "The Thirukkural has profoundly influenced Tamil culture and literature for centuries. Its universal messages transcend religious and cultural boundaries, making it relevant across different societies and time periods."
                        )
                        
                        historySection(
                            title: "Modern Significance",
                            content: "Today, the Thirukkural continues to be widely studied and revered. Its principles are taught in schools, referenced in political discourse, and applied in daily life. The text has been translated into numerous languages, spreading its wisdom globally."
                        )
                        
                        historySection(
                            title: "Literary Excellence",
                            content: "Each couplet in the Thirukkural is crafted with remarkable precision, conveying deep philosophical ideas in just seven words in Tamil. This brevity and depth have earned it the title 'Ulaga Podhu Marai' (Universal Scripture)."
                        )
                    }
                    .padding()
                }
            }
        }
        .background(AppColors.primaryBG)
        .navigationBarHidden(true)
    }
    
    private func historySection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: fontSize(20)))
                .fontWeight(.semibold)
            
            Text(content)
                .font(.system(size: fontSize(17)))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}


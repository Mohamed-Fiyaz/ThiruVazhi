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
    @Binding var scrollProxy: ScrollViewProxy?
    
    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3
        }
        return size
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(alignment: .leading, spacing: 20) {
                        Color.clear.frame(height: 0).id("top")
                        Text("History of Thirukkural")
                            .font(.system(size: fontSize(22)))
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            historySection(
                                title: "Origins",
                                content: "Thirukkural was authored by Thiruvalluvar who was a Tamil poet and philosopher. Though we are not aware of the exact time Thirukkural was composed, people believe that it was between the 3rd century BCE and 1st century CE, well over 2,000 years. Thirukkural consists of 1,330 couplets (Kurals), arranged into 133 chapters, each containing 10 couplets. These Kurals contain ethical and moral values applicable to all aspects of life. Anyone can relate themselves with each Kural, regardless of their religion, caste or region."
                            )
                            
                            historySection(
                                title: "Structure and Content",
                                content: "Thirukkural is divided into three books: Book I - Aram (Virtue), Book II - Porul (Wealth), and Book III - Inbam (Love). The first book, Aram, consists of 380 couplets that talk about righteousness, moral values, and the ethical duties of individuals. The second book, Porul, is the longest, offering 700 couplets, and talks about insights into governance, politics, economics, leadership, and social responsibilities. The third book, Inbam, with 250 couplets, talks about human emotions, love, and relationships in a poetic manner."
                            )
                            
                            historySection(
                                title: "Cultural Impact",
                                content: "In Tamil Nadu, people take pride in their language (Tamil) and culture. They even believe that Tamil is the oldest language in the world. Thirukkural is one of the most famous creations of ancient Tamil literature. In Tamil Nadu, Thirukkural is a mandatory part of the school curriculum, therefore, most of the children in Tamil Nadu are encouraged to memorize Thirukkurals and make use of its teachings."
                            )
                            
                            historySection(
                                title: "Modern Significance",
                                content: "Politicians, business leaders, and academicians refer to Thirukkural for ethical leadership and decision-making. The Kurals are often cited in social movements for advocating justice and equality. It is one of the most translated books after the Bible, spreading its wisdom across cultures. World leaders like Mahatma Gandhi have admired Thirukkural for its philosophical insights."
                            )
                            
                            historySection(
                                title: "How Thirukkural Influences Everyday Life",
                                content: "Thirukkural’s teachings continue to guide everyone by offering timeless wisdom on morality, discipline, and social responsibility, especially in Tamil culture, where it influences personal ethics, relationships, and governance. Many people apply its guidance in their daily lives. Parents and teachers encourage children to learn and recite Kurals. Its universal nature makes it relevant across all cultures, inspiring individuals to live a virtuous and purposeful life."
                            )
                            
                        }
                        .padding()
                    }
                    .onAppear {
                        scrollProxy = proxy
                    }
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
                .padding(.bottom, 10)
            
            Text(content)
                .font(.system(size: fontSize(17)))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(6)
                .padding(.bottom, 20)
        }
    }
}


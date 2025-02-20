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
                                content: "The Thirukkural, written by the revered poet-philosopher Thiruvalluvar, is an ancient Tamil literary masterpiece believed to have been composed between the 3rd century BCE and 1st century CE. The exact period of its origin remains a subject of debate among scholars, but its profound wisdom has transcended time. Thirukkural is a collection of 1,330 couplets (kurals), systematically arranged into 133 chapters, each containing 10 couplets. These kurals encapsulate ethical and moral values applicable to all aspects of life. The work is known for its secular nature, making it relevant to people of all backgrounds, irrespective of religion, caste, or region."
                            )

                            historySection(
                                title: "Structure and Content",
                                content: "Thirukkural is meticulously divided into three major sections: Aram (Virtue), Porul (Wealth), and Inbam (Love). The first section, Aram, consists of 380 couplets that emphasize righteousness, moral values, and the ethical duties of individuals. The second section, Porul, is the longest with 700 couplets, offering profound insights into governance, politics, economics, leadership, and social responsibilities. The third section, Inbam, with 250 couplets, explores human emotions, love, and relationships in a deeply poetic manner. This triadic structure reflects a holistic approach to life, guiding individuals toward an ideal existence."
                            )

                            historySection(
                                title: "Philosophy and Ethical Teachings",
                                content: "One of the most remarkable aspects of Thirukkural is its universal applicability. Thiruvalluvar advocates ethical living, truthfulness, compassion, and non-violence. His teachings align with various philosophical and religious traditions, including Hinduism, Jainism, and Buddhism, yet the text remains non-sectarian. The Thirukkural discourages caste-based discrimination, emphasizing equality and justice. It upholds virtues such as humility, gratitude, and self-discipline, making it a guide not just for personal morality but also for the ethical governance of a state."
                            )

                            historySection(
                                title: "Cultural Impact",
                                content: "Thirukkural has left an indelible mark on Tamil culture and literature for over two millennia. It has been revered by poets, scholars, and philosophers across generations. The text is often quoted in Tamil literature, classical poetry, and even modern-day discourse. Its ethical and moral teachings have inspired Tamil rulers, social reformers, and leaders, shaping governance and legal systems. The influence of Thirukkural extends beyond Tamil Nadu, with many historical and contemporary figures referring to its wisdom. The text is often inscribed in government institutions, public spaces, and even translated into numerous languages to reach a global audience."
                            )

                            historySection(
                                title: "Modern Significance",
                                content: "Even in contemporary society, Thirukkural continues to be a source of inspiration. It is included in school curriculums across Tamil Nadu and beyond, ensuring that its wisdom reaches younger generations. Politicians, business leaders, and academicians refer to its teachings for ethical leadership and decision-making. The text is often cited in social movements advocating justice and equality. It has been translated into over 40 languages, spreading its wisdom across cultures. Many world leaders, including Mahatma Gandhi, have admired Thirukkural for its profound moral and philosophical insights. The UNESCO-recognized work is a testament to its enduring relevance."
                            )

                            historySection(
                                title: "Literary Excellence",
                                content: "Thirukkural is regarded as a linguistic and literary marvel. Each couplet, written in just seven words in Tamil, conveys deep and complex philosophical ideas with stunning clarity and brevity. This remarkable precision has earned it the title 'Ulaga Podhu Marai' (Universal Scripture), highlighting its global significance. Unlike many other ancient texts, Thirukkural does not belong to any specific religious doctrine, making it a work of pure wisdom. The poetic beauty of Thirukkural lies in its rhythm, wordplay, and profound yet simple expressions. It remains one of the most translated, studied, and revered literary works in world history."
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


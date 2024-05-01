//
//  GuideComponent.swift
//  Honeymoon
//
//  Created by Denis Yaremenko on 30.04.2024.
//

import SwiftUI

struct GuideComponent: View {
    
    // MARK: - Properties
    var title: String
    var subtitle: String
    var description: String
    var icon: String
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.pink)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title.uppercased())
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    Text(subtitle.uppercased())
                        .font(.footnote)
                        .foregroundColor(.pink)
                    }
                
                Divider()
                    .padding(.bottom, 4)
                
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

#Preview {
    GuideComponent(
        title: "title", 
        subtitle: "subtitle",
        description: "description",
        icon: "heart.circle"
    )
        .previewLayout(.sizeThatFits)
}

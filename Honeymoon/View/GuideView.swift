//
//  GuideView.swift
//  Honeymoon
//
//  Created by Denis Yaremenko on 30.04.2024.
//

import SwiftUI

struct GuideView: View {
    
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                Spacer(minLength: 10)
                Text("Get started")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                    
                
                Text("Discover and pick the perfect destination for your romantic honeymoon")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 10)
                
                VStack(alignment: .leading, spacing: 25) {
                    GuideComponent(title: "Like", subtitle: "Swipe right", description: "Do you like this destination? Touch the screen and swipe right. It will be saved to the favourites.", icon: "heart.circle")
                    
                    
                    GuideComponent(title: "Dismiss", subtitle: "Swipe left", description: "Would you rather skip this place? Touch the screen and swipe left. You will no longer see it.", icon: "xmark.circle")
                    
                    GuideComponent(title: "Book", subtitle: "Tap the button", description: "Our selection of honeymoon resorts is perfect setting for you to embark your new life together.", icon: "checkmark.square")
                }
                
                Spacer(minLength: 10)
                
                Button(action:  {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("continue".uppercased())
                        .modifier(ButtonModifier())
                }
            }
            .frame(minWidth: .zero, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    GuideView()
}

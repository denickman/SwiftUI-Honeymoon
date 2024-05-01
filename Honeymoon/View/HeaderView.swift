//
//  HeaderView.swift
//  Honeymoon
//
//  Created by Denis Yaremenko on 29.04.2024.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - Properties
    @Binding var showGuideView: Bool
    @Binding var showInfoView: Bool
    let haptics = UINotificationFeedbackGenerator()
    
    // MARK: - Body
    var body: some View {
        
        HStack {
            Button(action: {
                playSound(sound: "sound-click", type: "mp3")
                showInfoView.toggle()
                haptics.notificationOccurred(.success)
            }) {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
            .sheet(isPresented: $showInfoView) {
                InfoView()
            }
            
            
            Spacer()
            
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            Button(action: {
                playSound(sound: "sound-click", type: "mp3")
                self.showGuideView.toggle()
                haptics.notificationOccurred(.success)
            }) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .sheet(isPresented: $showGuideView) {
                GuideView()
            }
            .accentColor(Color.primary)
        }
        .padding()
    }
}

//#Preview {
//    HeaderView(showGuideView: .constant(false), showInfoView: .constant(false))
//}

struct HeaderView_Previews: PreviewProvider {
    @State static var showGuide = false
    @State static var showInfo = false
    
    static var previews: some View {
        HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}

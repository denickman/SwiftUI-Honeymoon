//
//  FooterView.swift
//  Honeymoon
//
//  Created by Denis Yaremenko on 29.04.2024.
//

import SwiftUI

struct FooterView: View {
    
    // MARK: - Properties
    
    @Binding var showBookingAlert: Bool
    let haptics = UINotificationFeedbackGenerator()
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 42, weight: .light))
            Spacer()
            Button(action: {
                playSound(sound: "sound-click", type: "mp3")
                self.haptics.notificationOccurred(.success)
                self.showBookingAlert.toggle()
            }) {
                Text("Book destination".uppercased())
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.heavy)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .accentColor(Color.pink)
                    .background(
                    Capsule()
                        .stroke(Color.pink, lineWidth: 2)
                    )
            }
            Spacer()
            Image(systemName: "heart.circle")
                .font(.system(size: 24, weight: .light))
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    
    @State static var showAlert = false
    
    static var previews: some View {
        FooterView(showBookingAlert: $showAlert)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}

//#Preview {
//    FooterView()
//}

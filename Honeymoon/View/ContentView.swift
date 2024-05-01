//
//  ContentView.swift
//  Honeymoon
//
//  Created by Denis Yaremenko on 18.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    enum DragState {
        case inactive, pressing, dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(translation: let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    // MARK: - Properties
    
    @State var showAlert = false
    @State var showGuide = false
    @State var showInfo = false
    @State var lastCardIndex: Int = 1
    @State private var cardRemovalTransition = AnyTransition.trailingBottom
    @GestureState private var dragState = DragState.inactive
    private let dragAreaThreshold: CGFloat = 65.0
    
    
    
    
    // MARK: - Card Views
    
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(CardView(honeymoon: honeymoonData[index]))
        }
        return views
    }()
    
    // MARK: - Move the card
    private func moveCards() {
        cardViews.removeFirst()
        self.lastCardIndex += 1
        let hmoon = honeymoonData[lastCardIndex % honeymoonData.count]
        let newCardView = CardView(honeymoon: hmoon)
        cardViews.append(newCardView)
    }
    
    var body: some View {
        VStack {
            // MARK: - Header
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                .opacity(dragState.isDragging ? .zero : 1.0)
                .animation(.default)
            Spacer()
            
            // MARK: - Cards
            ZStack {
                ForEach(cardViews) { cView in
                    cView
                        .zIndex(self.isTopCard(cardView: cView) ? 1 : 0)
                        .overlay(
                            ZStack {
                                // x-mark symbol
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(self.dragState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardView: cView) ? 1.0 : 0.0)
                                
                                // heart symbol
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(self.dragState.translation.width > self.dragAreaThreshold && self.isTopCard(cardView: cView) ? 1.0 : 0.0)
                            }
                        )
                        .offset(x: self.isTopCard(cardView: cView) ?  dragState.translation.width : 0, y: self.isTopCard(cardView: cView) ? dragState.translation.height : 0)
                        .scaleEffect(dragState.isDragging && self.isTopCard(cardView: cView) ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cView) ? Double(self.dragState.translation.width / 12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                            
                            .sequenced(before: DragGesture())
                            .updating($dragState, body: {
                                value, state, transaction in
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                            })
                                 
                                .onChanged({value in
                                    guard case .second (true, let drag?) = value else { return }
                                    
                                    if drag.translation.width < -self.dragAreaThreshold {
                                        self.cardRemovalTransition = .leadingBottom
                                    }
                                    
                                    if drag.translation.width > self.dragAreaThreshold {
                                        self.cardRemovalTransition = .trailingBottom
                                    }
                                            
                                })
                                .onEnded({ value in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > self.dragAreaThreshold {
                                        playSound(sound: "sound-rise", type: "mp3")
                                        self.moveCards()
                                    }
                                })
                        ) // end .gesture
                        .transition(cardRemovalTransition)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // MARK: - Footer
            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? .zero : 1.0)
                .animation(.interpolatingSpring)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Wishing a lovely and most precious of the times together for the amazing couple."),
                dismissButton: .default(Text("Happy honeymoon"))
            )
        }
    }
}

extension ContentView {
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: {$0.id == cardView.id }) else {
            return false
        }
        return index == 0
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Animations
//
//  Created by Ejder Dağ on 23.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded {_ in dragAmount = .zero }
            )
            .animation(.spring(), value: dragAmount)
    }
    
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

#Preview {
    ContentView()
}

/*
 @State private var isShowingRed = false

 var body: some View {
     ZStack {
         Rectangle()
             .fill(.blue)
             .frame(width: 200, height: 200)
         
         if isShowingRed {
             Rectangle()
                 .fill(.red)
                 .frame(width: 200, height: 200)
                 .transition(.pivot)
         }
     }
     .onTapGesture {
         withAnimation {
             isShowingRed.toggle()
         }
     }
 }
 */

/*
 VStack {
     Button("Tap Me") {
         withAnimation {
             isShowingRed.toggle()
         }
     }
     
     if isShowingRed {
         Rectangle()
             .fill(.red)
             .frame(width: 200, height: 200)
             //.transition(.scale)
             .transition(.asymmetric(insertion: .scale, removal: .opacity))
     }
 }
 */

/*
 HStack(spacing: 0) {
     ForEach(0..<letters.count, id: \.self) { num in
         Text(String(letters[num]))
             .padding(5)
             .font(.title)
             .background(enabled ? .blue : .red)
             .offset(dragAmount)
             .animation(.linear.delay(Double(num) / 20), value: dragAmount)
     }
 }
 .gesture(
     DragGesture()
         .onChanged { dragAmount = $0.translation }
         .onEnded { _ in
             dragAmount = .zero
             enabled.toggle()
         }
 )
 */
/*
 LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
     .frame(width: 300, height: 200)
     .clipShape(.rect(cornerRadius: 10))
     .offset(dragAmount)
     .gesture(
         DragGesture()
             .onChanged { dragAmount = $0.translation}
             .onEnded { _ in
                 withAnimation(.bouncy) {
                     dragAmount = .zero
                 }
             }
     )
     //.animation(.bouncy, value: dragAmount)
 */
/*
 Button("Tap Me") {
     enabled.toggle()
 }
 .frame(width: 200, height: 200)
 .background(enabled ? .blue : .red)
 .animation(nil, value: enabled)
 .foregroundStyle(.white)
 .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
 .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
 */


/*
 Button("Tap Me") {
     withAnimation(.spring(duration: 1, bounce: 0.5)) {
         animationAmount += 360
     }
 }
 .padding(50)
 .background(.red)
 .foregroundStyle(.white)
 .clipShape(.circle)
 .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
 */
/*
 print(animationAmount)
 
 return VStack {
     //Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
     
     Stepper("Scale amount", value: $animationAmount.animation(
         .easeInOut(duration: 1)
         .repeatCount(3, autoreverses: true)
     ), in: 1...10)
     
     Spacer()
     
     Button("Tap Me") {
         animationAmount += 1
     }
     .padding(40)
     .background(.red)
     .foregroundStyle(.white)
     .clipShape(.circle)
     .scaleEffect(animationAmount)
 }
 */


/*
 VStack {
     Button("Tap Me") {
         //animationAmount += 1
     }
     .padding(50)
     .background(.blue)
     .foregroundStyle(.white)
     .clipShape(.circle)
     //.scaleEffect(animationAmount)
     .overlay(
         Circle()
             .stroke(.red)
             .scaleEffect(animationAmount)
             .opacity(2 - animationAmount)
             .animation(
                 .easeOut(duration: 1)
                 .repeatForever(autoreverses: false),
                 value: animationAmount
             )
     )
     .onAppear {
         animationAmount = 2
     }
     //            .animation(
//                .easeInOut(duration: 1)
//                    .repeatForever(autoreverses: true),
//                value: animationAmount
//            )
//            .animation(
//                .easeInOut(duration: 1)
//                    .repeatCount(3, autoreverses: true),
//                value: animationAmount
//            )
//            .animation(
//                .easeInOut(duration: 2)
//                    .delay(1), // animasyonu başlatmadan önce bir saniye bekle.
//                value: animationAmount
//            )
     //.animation(.easeInOut(duration: 3), value: animationAmount)
     //.animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
     //.blur(radius: (animationAmount - 1) * 3)
 }
 */

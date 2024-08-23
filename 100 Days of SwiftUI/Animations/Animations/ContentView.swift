//
//  ContentView.swift
//  Animations
//
//  Created by David Williams on 8/23/24.
//

import SwiftUI


struct cornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition {
        .modifier(active: cornerRotateModifier(amount: -90.0, anchor: .topLeading),
                  identity: cornerRotateModifier(amount: 0.0, anchor: .topLeading))
    }
}
    
struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var animationRotation = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    let letters = Array("Hello SwiftUI")

    var body: some View {
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            if isShowingRed{
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation{
                isShowingRed.toggle()
            }
        }
        /*
        VStack {
            Button("Tap Me"){
                withAnimation{
                    isShowingRed.toggle()
                }
            }
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
         */
        /*
        VStack(spacing: 50){
            HStack(spacing: 0){
                ForEach(0..<letters.count, id: \.self){num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(dragAmount)
                        .animation(.linear.delay(Double(num) / 20), value:dragAmount)
                        .gesture(
                            DragGesture()
                                .onChanged{dragAmount = $0.translation}
                                .onEnded{ _ in
                                    dragAmount = .zero
                                    enabled.toggle()
                                }
                        )
                }
            }
            LinearGradient(colors: [.yellow,.black], startPoint: .bottom, endPoint: .top)
                .frame(width: 300, height: 200)
                .clipShape(.rect(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged{dragAmount = $0.translation}
                        .onEnded{_ in
                            withAnimation{
                                dragAmount = .zero
                            }
                        }
                )
            Stepper("Scale Amount", value: $animationAmount.animation(
                .easeInOut(duration: 1).repeatForever(autoreverses: true)
            ), in: 1...10)
            Button("Tap Me"){
                withAnimation(.bouncy(duration: 1)){animationRotation += 360}
                enabled.toggle()
            }
            .frame(width: 100, height: 100)
            .background(enabled ? .black : .yellow)
            .foregroundStyle(enabled ? .yellow : .black)
            .fontWeight(enabled ? .bold : .regular)
            .animation(.default, value: enabled)
            .clipShape(.rect(cornerRadius: enabled ? 100 : 0))
            .animation(.spring(duration: 1, bounce: 0.9), value: enabled)
            .rotation3DEffect(.degrees(animationRotation),axis: (x: 0.0, y: 1.0, z: 0.0))
            .onAppear{
                animationAmount = 2
            }
            
        }
        .padding(40)
         */
    }
}

#Preview {
    ContentView()
}

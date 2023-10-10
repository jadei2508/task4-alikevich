//
//  ContentView.swift
//  task4
//
//  Created by Роман on 07/10/2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        HStack {
            TrackButton(scale: 0, duration: 1)
            TrackButton(scale: 0.86, duration: 0.22)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CustomButtonStyle: ButtonStyle {
    
    @State private var isSelected: Bool = false
    private var duration: Double
    private var scale: Double
    
    init(scale: Double, duration: Double) {
        self.scale = scale
        self.duration = duration
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.green)
            .background(isSelected ? Color.mint : .white)
            .opacity(0.8)
            .clipShape(Circle())
            .onChange(of: configuration.isPressed) { newValue in
                isSelected = true
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    isSelected = false
                }
            }.scaleEffect(isSelected ? scale : 1)
            .animation(.linear(duration: duration), value: isSelected)
            .disabled(isSelected)
    }
}

struct TrackButton: View {
    
    @State private var isActive: Bool = false
    private var scale: Double
    private var duration: Double
    
    init(scale: Double, duration: Double) {
        self.scale = scale
        self.duration = duration
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.interpolatingSpring(stiffness: 100, damping: 15)) {
                isActive = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isActive = false
            }
        }){
            HStack(spacing: 0) {
                ZStack {
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .offset(x: isActive ? 32 : .zero)

                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .offset(x: isActive ? .zero : -16)
                        .opacity(isActive ? 1 : .zero)
                        .scaleEffect(isActive ? 1 : 0.2)
                }
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                        .offset(x: isActive ? 16 : .zero)
                        .opacity(isActive ? .zero : 1)
                        .scaleEffect(isActive ? 0.2 : 1)
            }.padding(20)
             .frame(width: 104, height: 104)
        }
        .padding(20)
        //        .frame(width: 104, height: 104)
        .buttonStyle(CustomButtonStyle(scale: scale, duration: duration))
    }
}

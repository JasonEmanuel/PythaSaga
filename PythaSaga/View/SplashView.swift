//
//  SplashView.swift
//  PythaSaga
//
//  Created by Jason Emanuel on 26/04/24.
//

import SwiftUI

struct SplashView: View {
    @State var isActive : Bool = false
    @State private var size = 0.4
    @State private var opacity = 0.5
    
    let colorModel = useColor()
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            Color(colorModel.bgColor)
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        Image("Splash")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white)
                        
                        Text("PythaSaga")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.top, 0.5)
                            .foregroundStyle(.white)
                    }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.spring(duration: 1.2)) {
                                self.size = 2
                                self.opacity = 1
                            }
                        }
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
}

#Preview {
    SplashView()
}

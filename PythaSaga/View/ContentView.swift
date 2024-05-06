//
//  ContentView.swift
//  PythaSaga
//
//  Created by Jason Emanuel on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showNightSky = false
    @State private var showExitAlert = false
    @State private var confirmExit = false
    @State private var showHowToPlay = false
    
    let imgName = "GrapemanWalking"
    let colorModel = useColor()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(colorModel.bgColor)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        HStack{
                            Text("Welcome to,")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.leading, 30)
                        .padding(.top, 50)
                        
                        HStack{
                            Text("PythaSaga")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .foregroundColor(Color(colorModel.titleColor))
                            Spacer()
                        }
                        .padding(.leading, 30)
                        Spacer()
                    }
                }
                .padding(.leading, 30)
                .padding(.bottom, 10)
                
                VStack {
                    VStack(spacing: 0){
                        HStack{
                            AtlasImage(
                                imageName: imgName,
                                columns: 8,
                                rows: 1,
                                fps: 6.0,
                                size: CGSize(width: 50, height: 50),
                                reverseAnimation: false,
                                repeatAnimation: true
                            )
                            .padding(.top, 80)
                            .padding(.trailing, 100)
                        }
                        VStack(spacing: 0) {
                            Image("Terrain")
                                .resizable(resizingMode: .tile)
                                .frame(height: 45)
                                .frame(width: 325)
                        }
                    }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                        .padding(.top, 80)
                        .background(
                            Image("bgintro")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 325, height: 200)
                                .clipped()
                                .cornerRadius(20)
                                .padding(.top, 50)
                        )
                    
                    VStack(spacing: 30) {
                        Button(action: {
                            showNightSky = true
                        }) {
                            Text("Sunny Forest")
                                .font(.system(size: 20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .frame(width: 250, height: 50)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    Image("bgbutton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(20)
                                )
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            showHowToPlay = true
                        }) {
                            Text("How to Play")
                                .font(.system(size: 20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .frame(width: 250, height: 50)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(colorModel.blueButtonColor))
                                .cornerRadius(20)
                        }
                        
                        
                        .alert(isPresented: $showHowToPlay) {
                            Alert(
                                title: Text("How to Play"),
                                message: Text("This is how to play")
                            )
                        }
                        
                        Button(action: {
                            showExitAlert = true
                        }) {
                            Text("Exit Game")
                                .font(.system(size: 20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .frame(width: 250, height: 50)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(colorModel.redButtonColor))
                                .cornerRadius(20)
                        }
                        
                        .alert(isPresented: $showExitAlert) {
                            Alert(
                                title: Text("Exit Game"),
                                message: Text("Are you sure you want to quit?"),
                                primaryButton: .destructive(Text("Quit"), action: {
                                    self.confirmExit = true
                                }),
                                secondaryButton: .cancel(Text("Cancel"))
                            )
                        }
                        
                        .onChange(of: confirmExit) { newValue in
                            if newValue {
                                exit(0)
                            }
                        }
                    }
                    .padding(.top, 15)
                    
                    // Nav Link for Button Game
                    NavigationLink(
                        destination: BattleView(),
                        isActive: $showNightSky,
                        label: {
                            EmptyView()
                        }
                    )
                }
                .padding(.top, 40)
            }
        }
    }
}

#Preview {
    ContentView()
}

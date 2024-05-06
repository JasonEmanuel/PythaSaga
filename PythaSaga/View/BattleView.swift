//
//  NightSkyView.swift
//  PythaSaga
//
//  Created by Jason Emanuel on 29/04/24.
//

import SwiftUI

struct BattleView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var attack = true
    @State private var imgName = "GrapemanIdle"
    @State private var showQuestion = false
    @State internal var gameEnd = false
    @State private var showNightSky = false
    @State private var timer: Timer?
    @State private var playerHP = 5
    @State private var enemyHP = 5
    @State private var isAnimate = true
    @State private var showAlert = false
    @State private var correctAnswers = 0
    @State private var ultiStatus = false
    @State private var showAlertUlt = false
    @State private var currQuestion: PythagorasQuestion? = PythagorasQuestion.allQuestions.first
    
    // Animasi
    @State var arrayImage = ["GrapemanIdle", "GrapemanAngy"]
    @State var arrayColumns = [6, 4]
    @State var picked = 0
    
    let colorModel = useColor()
    
    
    func getRandomQuestion() -> PythagorasQuestion {
        let randomIndex = Int.random(in: 0..<PythagorasQuestion.allQuestions.count)
        return PythagorasQuestion.allQuestions[randomIndex]
    }
    
    
    var body: some View {
        ZStack{
            Color(colorModel.bgColor)
                .ignoresSafeArea()
            
            VStack {
                Text("Defeat The Enemy")
                    .font(.title)
                    .bold()
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(colorModel.blueButtonColor))
                    .frame(width: 350, height: 200)
                    .overlay(
                        VStack(spacing: 0){
                            HStack{
                                AtlasImage(
                                    imageName: arrayImage[picked],
                                    columns: arrayColumns[picked],
                                    rows: 1,
                                    fps: 8,
                                    size: CGSize(width: 50, height: 50),
                                    reverseAnimation: false,
                                    repeatAnimation: true
                                )
                                .padding(.top, 85)
                                .padding(.leading)

                                Spacer()
                                HStack {
                                    if attack {
                                        AtlasImage(
                                            imageName: "rinorun",
                                            columns: 6,
                                            rows: 1,
                                            fps: 8,
                                            size: CGSize(width: 70, height: 70),
                                            reverseAnimation: false,
                                            repeatAnimation: isAnimate
                                        )
                                        .padding(.top, 65)
                                        .padding(.trailing)
                                        .offset(y: 15)
                                    } else {
                                        AtlasImage(
                                            imageName: "rinohit",
                                            columns: 5,
                                            rows: 1,
                                            fps: 6,
                                            size: CGSize(width: 70, height: 70),
                                            reverseAnimation: false,
                                            repeatAnimation: isAnimate
                                        )
                                        .padding(.top, 65)
                                        .padding(.trailing)
                                        .offset(y:15)
                                    }
                                }
                            }
                            VStack(spacing: 0) {
                                Image("Terrain")
                                    .resizable(resizingMode: .tile)
                                    .frame(height: 45)
                                    .frame(width: 350)
                            }
                        }
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.bottom, -30)
                    )
                    .padding()
                
                VStack{
                    HStack {
                        // Avatar Player
                        AtlasImage(
                            imageName: arrayImage[picked],
                            columns: 6,
                            rows: 1,
                            fps: 8,
                            size: CGSize(width: 40, height: 50),
                            reverseAnimation: false,
                            repeatAnimation: true
                        )
                        .padding(.trailing)
                        // Heart Player
                        ForEach(0..<max(playerHP, 0), id: \.self) { _ in
                            AtlasImage(
                                imageName: "heart",
                                columns: 1,
                                rows: 1,
                                fps: 1,
                                size: CGSize(width: 40, height: 40),
                                reverseAnimation: false,
                                repeatAnimation: true
                            )
                        }
                        Spacer()
                    }
                    .padding(.leading, 40)
                    HStack {
                        // Avatar Player
                        ForEach(0..<max(enemyHP, 0), id: \.self) { _ in
                            AtlasImage(
                                imageName: "heart",
                                columns: 1,
                                rows: 1,
                                fps: 1,
                                size: CGSize(width: 40, height: 40),
                                reverseAnimation: false,
                                repeatAnimation: true
                            )
                        }
                        Spacer()
                        // Heart Player
                        AtlasImage(
                            imageName: "rinoidle",
                            columns: 11,
                            rows: 1,
                            fps: 8,
                            size: CGSize(width: 60, height: 50),
                            reverseAnimation: false,
                            repeatAnimation: true
                        )
                        .padding(.trailing, 50)
                    }
                    .padding(.leading, 40)
                    .padding(.top)
                }
                
                Text("Choose your attack")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .padding(.top)
                    
                    .alert(isPresented: $gameEnd) {
                        if playerHP <= 0 {
                            return Alert(title: Text("Game Over"), message: Text("You lost!"), dismissButton: .default(Text("OK")) {
                                presentationMode.wrappedValue.dismiss()
                            })
                        } else {
                            return Alert(title: Text("Congratulations"), message: Text("You won!"), dismissButton: .default(Text("OK")) {
                                presentationMode.wrappedValue.dismiss()
                            })
                        }
                    }
                    .sheet(isPresented: $showQuestion) {
                        PythagorasPopupView(
                            question: currQuestion ?? getRandomQuestion(),
                            isShowing: $showQuestion,
                            playerHP: $playerHP,
                            enemyHP: $enemyHP,
                            gameEnd: $gameEnd,
                            showAlert: $showAlert,
                            correctAnswers: $correctAnswers,
                            ultStatus: $ultiStatus,
                            currQuestion: $currQuestion
                        )
                    }
                
                Button(action: {
                    picked  = (picked + 1) % 2
                }) {
                    Text("Tes Animasi")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 250, height: 50)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(colorModel.blueButtonColor))
                        .cornerRadius(20)
                }
                
                if !gameEnd {
                    Button(action: {
                        attack.toggle()
                        showQuestion.toggle()

                        if attack {
                            imgName = "GrapemanIdle"
                        } else {
                            imgName = "GrapemanAngy"
                        }
                    }) {
                        Text("Normal Attack")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .frame(width: 250, height: 50)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(colorModel.blueButtonColor))
                            .cornerRadius(20)
                    }
                }
                
                Button(action: {
                    if correctAnswers >= 3 {
                        if !ultiStatus {
                            ultiStatus = true
                            showQuestion.toggle()
                            if showQuestion == false {
                                correctAnswers = 0
                                ultiStatus = false
                            }
                        }
                    } else {
                        showAlertUlt = true
                    }
                }) {
                    Text("Ultimate")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 250, height: 50)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(colorModel.blueButtonColor))
                        .cornerRadius(20)
                }
                .alert(isPresented: $showAlertUlt) {
                    Alert(title: Text("Warning"), message: Text("Ultimate not available"), dismissButton: .default(Text("Ok"), action: {

                        }
                    ))
                }
                .padding(.top)
            }
        }
        .onChange(of: gameEnd) {
            dismiss()
        }
    }
}

#Preview {
    BattleView()
}

//
//  PythagorasPopupView.swift
//  PythaSaga
//
//  Created by Jason Emanuel on 02/05/24.
//

import SwiftUI

struct PythagorasPopupView: View {
    let question: PythagorasQuestion
    let battle = BattleView()
    @Binding var isShowing: Bool
    @Binding var playerHP: Int
    @Binding var enemyHP: Int
    @Binding var gameEnd: Bool
    @Binding var showAlert: Bool
    @Binding var correctAnswers: Int
    @Binding var ultStatus: Bool
    @Binding var currQuestion: PythagorasQuestion?
    @State private var selectedAnswerIndex: Int?
    @State private var checkText: String = ""
    @State private var alertMessage = ""
    @State private var isAnswered = false
    
    let colorModel = useColor()
    
    var body: some View {
        VStack {
            Text(question.question)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.top, 50)
                .bold()
            
            Image(question.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 250)
            
            Text(question.description)
                .padding(.bottom, 10)
                .font(.system(size: 15))
                .bold()
                .multilineTextAlignment(.center)
            
            VStack(spacing: 20) {
                ForEach(0..<question.answers.count, id: \.self) { index in
                    Button(action: {
                        selectedAnswerIndex = index
                        if index == question.correctAnswerIndex {
                            alertMessage = "Correct"
                            if ultStatus == true {
                                enemyHP -= 2
                                if correctAnswers >= 3 {
                                    ultStatus = false
                                }
                            } else {
                                enemyHP -= 1
                                correctAnswers += 1

                            }
                        } else {
                            alertMessage = "Wrong Choice"
                            playerHP -= 1
                            correctAnswers = 0
                            ultStatus = false
                        }
                        showAlert = true
                        if playerHP <= 0 || enemyHP <= 0 {
                            gameEnd = true
                            showAlert = false
                            isShowing = false
                        }

                    }) {
                        Text(question.answers[index])
                            .font(.title)
                            .padding(.horizontal, 100)
                            .padding()
                            .background(selectedAnswerIndex == index ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Answer"), message: Text(alertMessage), dismissButton: .default(Text("Ok"), action: {
                isShowing = false
                currQuestion = getRandomQuestion()
            }))
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding()
    }
    
    private func getRandomQuestion() -> PythagorasQuestion {
        let randomIndex = Int.random(in: 0..<PythagorasQuestion.allQuestions.count)
        return PythagorasQuestion.allQuestions[randomIndex]
    }
}


//struct PythagorasPopupView_Previews: PreviewProvider {
//    @State static var playerHp = 5
//    @State static var enemyHp = 5
//    @State static var gameEnd = false
//    @State static var showAlert = false
//    @State static var correctAnswers = 0
//    @State static var ultStatus = false
//    
//    static var previews: some View {
//        PythagorasPopupView(
//            question: PythagorasQuestion(
//                question: "Soal 1",
//                imageName: "soalpytha9",
//                description: "Find the length of PT",
//                answers: ["5", "7", "9"],
//                correctAnswerIndex: 2
//            ),
//            isShowing: .constant(true),
//            playerHP: $playerHp,
//            enemyHP: $enemyHp,
//            gameEnd: $gameEnd,
//            showAlert: $showAlert,
//            correctAnswers: $correctAnswers,
//            ultStatus: $ultStatus
//        )
//    }
//}

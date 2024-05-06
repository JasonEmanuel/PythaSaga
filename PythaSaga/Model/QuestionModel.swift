//
//  QuestionModel.swift
//  PythaSaga
//
//  Created by Jason Emanuel on 02/05/24.
//

import Foundation

struct PythagorasQuestion {
    let question: String
    let imageName: String
    let description: String
    let answers: [String]
    let correctAnswerIndex: Int
    
    static let allQuestions: [PythagorasQuestion] = [
        PythagorasQuestion(question: "Soal 1", imageName: "soalpytha1", description: "Find the length of BC", answers: ["4", "9", "12"], correctAnswerIndex: 0),
        PythagorasQuestion(question: "Soal 2", imageName: "soalpytha2", description: "Find the length of AC",answers: ["22", "29", "25"], correctAnswerIndex: 1),
        PythagorasQuestion(question: "Soal 3", imageName: "soalpytha3", description: "Find the length of BC",answers: ["16", "15", "19"], correctAnswerIndex: 0),
        PythagorasQuestion(question: "Soal 4", imageName: "soalpytha4", description: "Find the length of AB",answers: ["27", "13", "17"], correctAnswerIndex: 2),
        PythagorasQuestion(question: "Soal 5", imageName: "soalpytha5", description: "A boy travels 24 km towards east from his house, then he turned his left and covers another 10 km. Find out his total displacement? (OB)",answers: ["25", "26", "28"], correctAnswerIndex: 1),
        PythagorasQuestion(question: "Soal 6", imageName: "soalpytha6", description: "Find the distance between a tower and a building of height 65 m and 34 m, respectively, such that the distance between their top is 29 m.",answers: ["20", "30", "15"], correctAnswerIndex: 0),
        PythagorasQuestion(question: "Soal 7", imageName: "soalpytha7", description: "Find the length of AD or BC",answers: ["17", "19", "13"], correctAnswerIndex: 0),
        PythagorasQuestion(question: "Soal 8", imageName: "soalpytha8", description: "Find the length of PT",answers: ["10", "11", "8"], correctAnswerIndex: 2),
        PythagorasQuestion(question: "Soal 9", imageName: "soalpytha9", description: "Find the height of this triangle",answers: ["12", "8", "13"], correctAnswerIndex: 0),
        PythagorasQuestion(question: "Soal 10", imageName: "soalpytha10", description: "Find the length of AD",answers: ["12.5", "17", "4.5"], correctAnswerIndex: 2),
    ]
}

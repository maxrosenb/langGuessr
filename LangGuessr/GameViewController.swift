//
//  GameViewController.swift
//  LangGuessr
//
//  Created by Max Rosenberg on 7/19/20.
//  Copyright © 2020 Max Rosenberg. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  
  var gameModels = [Question]()
  var points = 0
  var currentQuestion: Question?
  
  @IBOutlet var label: UILabel!
  @IBOutlet var score: UILabel!
  @IBOutlet var table: UITableView!
  
  
  override func viewDidLoad() {
      // Do any additional setup after loading the view.
      super.viewDidLoad()
      setupQuestions()
      configureUI(question: gameModels.first!)

      
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    table.delegate = self
    table.dataSource = self
  }
  
  private func configureUI(question: Question) {
    label.text = question.text
    score.text = "\(points)"
    currentQuestion = question
    table.reloadData()
    
  
  }

  private func checkAnswer(answer: Answer, question: Question) -> Bool {
    return question.answers.contains(where: { $0.text == answer.text }) && answer.correct
  }

  private func setupQuestions() {
//    gameModels.append(Question(text: "Olá! Bem vindo ao meu mundo.", answers: [
//      Answer(text: "Spanish", correct: false),
//      Answer(text: "French", correct: false),
//      Answer(text: "Portuguese", correct: true),
//      Answer(text: "Russian", correct: false)
//    ]))
//    gameModels.append(Question(text: "Sveiki! Sveiki atvykę į mano pasaulį.", answers: [
//      Answer(text: "Lithuanian", correct: true),
//      Answer(text: "Croatian", correct: false),
//      Answer(text: "Estonian", correct: false),
//      Answer(text: "Luxembourgish", correct: false)
//    ]))
    questionBank.shuffle()
    for q in questionBank{
      gameModels.append(q)
    }
  }
  
  //table view functions
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentQuestion?.answers.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let question = currentQuestion else {
      return
    }
    let answer = question.answers[indexPath.row]
    
    if checkAnswer(answer: answer, question: question) {
      //Correct
      points += 100
      if let index = gameModels.firstIndex(where: {$0.text == question.text}) {
        if index <  (gameModels.count - 1) {
          // next question
          
          let nextQuestion = gameModels[index+1]
          configureUI(question: nextQuestion)
        }
        else {
          let alert = UIAlertController(title: "DONE", message: "You win", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Finish", style: .cancel, handler: nil))
          present(alert, animated: true)
          
        }
      }
      
    }
    else {
      //Wrong
      let alert = UIAlertController(title: "WRONG!", message: "You suck", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      present(alert, animated: true)
      
      
    }
  }
  var questionBank = [Question(text: "Olá! Bem vindo ao meu mundo.", answers: [
    Answer(text: "Spanish", correct: false),
    Answer(text: "French", correct: false),
    Answer(text: "Portuguese", correct: true),
    Answer(text: "Russian", correct: false)
  ]), Question(text: "Sveiki! Sveiki atvykę į mano pasaulį.", answers: [
    Answer(text: "Lithuanian", correct: true),
    Answer(text: "Croatian", correct: false),
    Answer(text: "Estonian", correct: false),
    Answer(text: "Luxembourgish", correct: false)
  ])]
    
}
  
struct Question {
  let text: String
  let answers: [Answer]
}

struct Answer {
  let text: String
  let correct: Bool
}



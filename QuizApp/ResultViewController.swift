//
//  ResultViewController.swift
//  QuizApp
//
//  Created by vinod supnekar on 12/02/21.
//

import UIKit

struct PresentableAnswer {
    let answer: String
    let question: String
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    @IBOutlet var questionLable: UILabel!
    @IBOutlet var answerLabel: UILabel!
}

class WrongAnswerCell: UITableViewCell {
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var correctAnswerLabel: UILabel!
    
}

class ResultViewController: UIViewController,UITableViewDataSource {

    private var summary = ""
    private var answers = [PresentableAnswer]()
    @IBOutlet var headerLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = summary
        tableView.register(UINib(nibName: "CorrectAnswerCell", bundle: nil), forCellReuseIdentifier: "CorrectAnswerCell")
        tableView.register(UINib(nibName: "WrongAnswerCell", bundle: nil), forCellReuseIdentifier: "WrongAnswerCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        
        if answer.isCorrect {
            return correctAnswerCell(for: answer)
        }
        return wrongAnswerCell(for: answer)
    }
    
    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectAnswerCell") as! CorrectAnswerCell
        cell.questionLable.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    private func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WrongAnswerCell") as! WrongAnswerCell
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        return cell
    }
}

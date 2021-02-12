//
//  ResultViewController.swift
//  QuizApp
//
//  Created by vinod supnekar on 12/02/21.
//

import UIKit

struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    
}

class WrongAnswerCell: UITableViewCell {
    
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        
        return answer.isCorrect ? CorrectAnswerCell() : WrongAnswerCell()
    }
}

//
//  ResultViewControllerTest.swift
//  QuizAppTests
//
//  Created by vinod supnekar on 12/02/21.
//

import XCTest
@testable import QuizApp

class ResultViewControllerTest: XCTestCase {

    func test_viewDidLoad_renderSummary() {
        XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_rendersAnswers() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)

        XCTAssertEqual(makeSUT(summary: "a summary", answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_rendersCorrectAnswerCell() {
        let sut = makeSUT( answers: [makeAnswer(isCorrect: true)])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)

    }
    
    func test_viewDidLoad_withCorrectAnswer_rendersQuestionText() {
        let answer = makeAnswer(question: "Q1", isCorrect:true)

        let sut = makeSUT( answers: [answer])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell?.questionLable.text, "Q1")

    }
    
    func test_viewDidLoad_withCorrectAnswer_configueresCell() {
        let answer = makeAnswer(question: "Q1",answer: "A1", isCorrect:true)

        let sut = makeSUT( answers: [answer])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell?.questionLable.text, "A1")
        XCTAssertNotNil(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configueresCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", isCorrect: false)

        let sut = makeSUT( answers: [answer])

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell?.questionLabel.text, "A1")
        XCTAssertNotNil(cell?.correctAnswerLabel.text, "A1")
    }
    
    
    func test_viewDidLoad_withWrongAnswer_rendersWrongAnswerCell() {
        let sut = makeSUT( answers: [makeAnswer(isCorrect: false)])

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)

    }
    
    //MARK: Helpers
    
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeDummyAnswer() -> PresentableAnswer {
        return  makeAnswer( isCorrect: false)
    }

    func makeAnswer(question: String = "",answer:String = "",isCorrect: Bool) -> PresentableAnswer {
        return PresentableAnswer(answer: answer, question: question, isCorrect: isCorrect)
    }
}

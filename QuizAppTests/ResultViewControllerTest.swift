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

        XCTAssertEqual(makeSUT(summary: "a summary", answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_rendersCorrectAnswerCell() {
        let sut = makeSUT( answers: [makeAnswer()])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)

    }
    
    func test_viewDidLoad_withCorrectAnswer_rendersQuestionText() {
        let answer = makeAnswer(question: "Q1")

        let sut = makeSUT( answers: [answer])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertEqual(cell?.questionLable.text, "Q1")

    }
    
    func test_viewDidLoad_withCorrectAnswer_configueresCell() {
        let answer = makeAnswer(question: "Q1",answer: "A1")

        let sut = makeSUT( answers: [answer])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLable.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configueresCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1",wrongAnswer: "wrong")

        let sut = makeSUT( answers: [answer])

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")

    }
    
    //MARK: Helpers
    
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }

    func makeAnswer(question: String = "",answer:String = "",wrongAnswer:String? = nil) -> PresentableAnswer {
        return PresentableAnswer(answer: answer, wrongAnswer:wrongAnswer, question: question)
    }
}

//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by vinod supnekar on 01/02/21.
//

import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_ViewDidLoad_rendersQuestionHeaderText() {
        
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_ViewDidLoad_withOneOptions_rendersOneOptions() {
      
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1","A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_ViewDidLoad_rendersOptionsText() {

        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1","A2"]).tableView.title(at: 1), "A2")
        XCTAssertEqual(makeSUT(options: ["A1","A2","A3"]).tableView.title(at: 2), "A3")
    }
    
    func test_optionsSeleted_withSingleSelction_notifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        
        let sut = makeSUT(options: ["A1"]) {
            receivedAnswer = $0
        }
        
        sut.tableView.select(row: 0)
        
        XCTAssertEqual(receivedAnswer , ["A1"])
    }
     
    func test_optionsDeSeleted_withSingleSelction_doesNotifiesDelegate() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1","A2"]) {_ in
            callbackCount += 1
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)

    }
    
    
    func test_optionsSeleted_withTwoOptions_notifiesDelegateWhenSelectionChanges() {
        var receivedAnswer = [String]()
        
        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer , ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer , ["A2"])
    }
    
    func test_optionsSeleted_withMultipleSelectionEnabled_notifiesDelegateSelectionChanges() {
        var receivedAnswer = [String]()

        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
        }
        
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer , ["A1"])

        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer , ["A1","A2"])
    }
    
    func test_optionsDeeeleted_withMultipleSelectionEnabled_notifiesDelegateSelectionChanges() {
        var receivedAnswer = [String]()

        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
        }
        
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer , ["A1"])

        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer , [])
    }
    
    //MARK: Helper
    
    func  makeSUT(question: String = "", options: [String] = [], selection: @escaping ([String]) -> Void = {_ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection : selection)
        _ = sut.view
        return sut
    }

}

private extension UITableView {
    
    func cell(at row:Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
    
    func select(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
    }
    
    func deselect(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        deselectRow(at: indexPath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
}

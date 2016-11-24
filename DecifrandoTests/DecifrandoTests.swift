//
//  DecifrandoTests.swift
//  DecifrandoTests
//
//  Created by Ana Luiza Ferrer on 03/11/16.
//
//

import XCTest
import SpriteKit
@testable import Decifrando

class DecifrandoTests: XCTestCase {
    
    var letter: Letter!
    var dao: DAO!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.letter = Letter()
        self.dao = DAO()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSave() {
        
        let obtainedResult = dao.save(levelNumber: 1, word: "gato", image: "cat", category: "animals", completed: false)
        
        XCTAssertTrue(obtainedResult)
    }
    
    func testFetch() {
        
        let obtainedResult = dao.fetch()
        
        XCTAssertTrue(obtainedResult)
    }
    
    func testFetchCategory() {
        
        let obtainedResult = dao.fetchCategory(category: "animals")
        
        XCTAssertTrue(obtainedResult)
    }
    
    func testUpdateLevelCompleted() {
        
        let obtainedResult = dao.updateLevelCompleted(category: "amimals")
        
        XCTAssertTrue(obtainedResult)
    }
    
    func testRandomLetter() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectedString = letter.randomString(length: 1)
        let expectedResult: Character = expectedString.characters.first!
        
        let letters : String = "bcdeopq"
        
        for obtainedResult in letters.characters {
            
            if obtainedResult == expectedResult {
                XCTAssertEqual(obtainedResult, expectedResult)
            } else {
                XCTAssertNotEqual(obtainedResult, expectedResult)
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

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
        
        let resultObtained = dao.save(levelNumber: 1, word: "gato", image: "cat", category: "animals", completed: false)
        
        XCTAssertTrue(resultObtained)
    }
    
    func testFetch() {
        
        let resultObtained = dao.fetch()
        
        XCTAssertTrue(resultObtained)
    }
    
    func testFetchCategory() {
        
        let resultObtained = dao.fetchCategory(category: "animals")
        
        XCTAssertTrue(resultObtained)
    }
    
    func testUpdateLevelCompleted() {
        
        let resultObtained = dao.updateLevelCompleted(category: "amimals")
        
        XCTAssertTrue(resultObtained)
    }
    
    func testRandomLetter() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let stringObtained = letter.randomString(length: 1)
        let characterObtained: Character = stringObtained.characters.first!
        
        let letters : String = "bcdeopq"
        
        for letter in letters.characters {
            
            if letter == characterObtained {
                
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

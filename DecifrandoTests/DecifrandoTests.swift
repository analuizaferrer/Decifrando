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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.letter = Letter()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let resultObtained = letter.randomString(length: 1)

        XCTAssertGreaterThanOrEqual(resultObtained, "b")
        XCTAssertLessThanOrEqual(resultObtained, "q")
        
//        let letterXPosition = 204.272735595703
//        let letterYPosition = 215.5
//        
//        let boxXPosition = 204.800003051758
//        let boxYPosition = 256.0
//        let boxWidth = 100.0
//        let boxHeight = 100.0
//        let boxYAnchorPoint = 0.75
//        
//        let xMin = boxXPosition - boxWidth/2
//        let xMax = boxXPosition + boxWidth/2
//        let yMin = boxYPosition - boxYAnchorPoint * boxHeight
//        let yMax = boxYPosition + (1 - boxYAnchorPoint) * boxHeight
//        
//        XCTAssertLessThan(xMin, letterXPosition)
//        XCTAssertLessThan(letterXPosition, xMax)
//        XCTAssertLessThan(yMin, letterYPosition)
//        XCTAssertLessThan(letterYPosition, yMax)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

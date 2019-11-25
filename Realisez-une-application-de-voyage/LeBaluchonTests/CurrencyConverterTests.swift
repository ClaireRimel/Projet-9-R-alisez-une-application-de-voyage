//
//  CurrencyConverterTests.swift
//  LeBaluchonTests
//
//  Created by Claire on 25/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class CurrencyConverterTests: XCTestCase {

    var sut: CurrencyConverter!
    
    override func setUp() {
      sut = CurrencyConverter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInvalidInputCharacter() {
        // Given
        let input = "A"
        let expectation = self.expectation(description: "")
        
        // When
        sut.convert(from: input) { (result) in
            // Then
            XCTAssertEqual(result, .failure(.invalidInput))
            expectation.fulfill()

        }
        //wait...
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testInvalidInputDoubleComma() {
        // Given
        let input = "2.."
        let expectation = self.expectation(description: "")
        
        // When
        sut.convert(from: input) { (result) in
            // Then
            XCTAssertEqual(result, .failure(.invalidInput))
            expectation.fulfill()
        }
        //wait...
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    func testPerformCalculationWithExistingData() {
        // Given
        sut.latestRateAndDate = CurrencyConverter.LatestRateAndDate(usdRate: 2.0, requestDate: "2019-11-25")
        let input = "100,00€"
        let expectation = self.expectation(description: "")

        // When
        sut.convert(from: input) { (result) in
             // Then
            XCTAssertEqual(result, .success(200))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    // Given
          // When
          // Then
}

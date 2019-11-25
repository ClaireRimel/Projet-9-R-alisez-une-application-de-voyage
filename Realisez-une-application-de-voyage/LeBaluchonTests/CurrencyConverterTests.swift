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
    var requestMock: RequestInterfaceMock!
    let apiKeyMock = "1234345"
    
    override func setUp() {
        requestMock = RequestInterfaceMock()
        sut = CurrencyConverter(session: requestMock, apiKey: apiKeyMock)
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
    
    func testRequestsDataIfTheresNoDataAndInputIsValid() {
        // Given
        sut.latestRateAndDate = nil
        let input = "100,00€"

        // When
        sut.convert(from: input) {_ in}
        
        //Then
        XCTAssertEqual(self.requestMock.request?.httpMethod, "GET")
        
        let url = requestMock.request?.url?.absoluteString
        let urlComponents = URLComponents(string: url!)
        
        XCTAssertEqual(urlComponents?.scheme, "http")
        XCTAssertEqual(urlComponents?.host, "data.fixer.io")
        XCTAssertEqual(urlComponents?.path, "/api/latest")
        XCTAssertEqual(urlComponents?.queryItems?[0], URLQueryItem(name: "access_key", value: apiKeyMock))
        XCTAssertEqual(urlComponents?.queryItems?[1], URLQueryItem(name: "base", value: "eur"))
        XCTAssertEqual(urlComponents?.queryItems?[2], URLQueryItem(name: "symbols", value: "usd"))
    }
    
    // Given
    // When
    // Then
}

final class RequestInterfaceMock: RequestInterface {
    
    var request: URLRequest?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        
        return URLSessionDataTask()
    }
}

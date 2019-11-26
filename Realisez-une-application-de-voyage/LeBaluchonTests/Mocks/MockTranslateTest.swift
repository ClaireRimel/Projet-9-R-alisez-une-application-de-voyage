//
//  MockTranslateTest.swift
//  LeBaluchonTests
//
//  Created by Claire on 26/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

@testable import LeBaluchon

final class RequestInterfaceMockTranslate: RequestInterface {
    
    var request: URLRequest?
    
    var response: LatestTranslationResponse?
    
    var error: Error?
    
    var data: Data?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        
        if let response = response {
            let data = try! JSONEncoder().encode(response)
            completionHandler(data, nil, nil)
            
        } else {
            completionHandler(data, nil, error)
        }
        
        return URLSessionDataTask()
    }
}


//
//  CurrencyModel.swift
//  LeBaluchon
//
//  Created by Claire on 29/10/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

class CurrencyConverter {
     
    func convert(from: Double, then: @escaping (Result<Double, CurrencyConverterError>) -> Void) {
                
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        
        //parameters
        urlComponents.queryItems = [URLQueryItem(name: "access_key", value: "4fc6ed95e4887dca01ddb1d5efe7c924"),
                                    URLQueryItem(name: "base", value: "eur"),
                                    URLQueryItem(name: "symbols", value: "usd")]
        
        // If this fail, it's because a programming error -> wrong URL
        guard let url = urlComponents.url else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            // Do something...
            print(data)
            print(response)
            print(error)
            
            if let error = error {
                DispatchQueue.main.async {
                    then(.failure(.requestError(error)))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                callback(false, nil)
                return
            }
            
            guard let data = data,
                let responseJSON = try? JSONDecoder().decode(LatestCurrencyResponse.self, from: data) else {
                    DispatchQueue.main.async {
                        then(.failure(.invalidResponseFormat))
                    }
                    return
            }
            print(responseJSON)
            
            guard let usdRate = responseJSON.rates["USD"] else {
                DispatchQueue.main.async {
                    then(.failure(.usdRateNotFound))
                }
                return
            }
            
            let usdValue = from * usdRate
            DispatchQueue.main.async {
                then(.success(usdValue))
            }
        })
        task.resume()
    }
}



//
//  ExchangeViewController.swift
//  LeBaluchon
//
//  Created by Claire on 16/10/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    let converter = CurrencyConverter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        converter.convert(from: 30) { (usdValue) in
            print(usdValue)
        }
    }
}

class CurrencyConverter {
    
    func convert(from: Double, then: @escaping (Double) -> Void) {
        //URL example:
        //http://data.fixer.io/api/latest?access_key=4fc6ed95e4887dca01ddb1d5efe7c924&base=eur&symbols=usd
                
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        
        //parameters
        urlComponents.queryItems = [URLQueryItem(name: "access_key", value: "4fc6ed95e4887dca01ddb1d5efe7c924"),
                                    URLQueryItem(name: "base", value: "eur"),
                                    URLQueryItem(name: "symbols", value: "usd")]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            // Do something...
            print(data)
            print(response)
            print(error)
            
            guard let data = data else { return }
            guard let responseJSON = try? JSONDecoder().decode(LatestCurrencyResponse.self, from: data) else { return }
            print(responseJSON)
            
            guard let usdRate = responseJSON.rates["USD"] else { return }
            let usdValue = from * usdRate
            then(usdValue)
        })
        task.resume()
    }
}

struct LatestCurrencyResponse: Codable {
    
    let success: Bool
    let timestamp: Double
    let base: String
    let date: String
    let rates: [String: Double]
}

//response example:

    /*
{"success":true,
 "timestamp":1572287346,
 "base":"EUR",
 "date":"2019-10-28",
 "rates":{"USD":1.10985}}
 */

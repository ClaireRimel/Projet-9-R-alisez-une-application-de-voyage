//
//  CurrencyModel.swift
//  LeBaluchon
//
//  Created by Claire on 29/10/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

class CurrencyConverter {
    
    struct LatestRateAndDate {
        var usdRate: Double
        var requestDate: String
    }
    
    var latestRateAndDate: LatestRateAndDate?
    
    let session: RequestInterface
    
    let apiKey: String
    
    // Default argument in function
    init(session: RequestInterface = URLSession.shared,
         apiKey: String = Bundle.main.object(forInfoDictionaryKey: "FIXER_CURRENCY_KEY") as! String) {
        self.session = session
        self.apiKey = apiKey
    }
    
    func convert(from: String, then: @escaping (Result<Double, CurrencyConverterError>) -> Void) {
        
        guard let value = convertToDouble(from: from, locale: Locale(identifier: "fr_FR"))
            else {
                then(.failure(.invalidInput))
                return
        }
        
        if let latestRateAndDate = latestRateAndDate, wasRequestMadeToday(requestDate: latestRateAndDate.requestDate) {
            
            let usdValue = value * latestRateAndDate.usdRate
            DispatchQueue.main.async {
                then(.success(usdValue))
            }
        } else {
            request(from: value, then: then)
        }
    }
    
    func request(from: Double, then: @escaping (Result<Double, CurrencyConverterError>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        
        //parameters
        urlComponents.queryItems = [URLQueryItem(name: "access_key", value: apiKey),
                                    URLQueryItem(name: "base", value: "eur"),
                                    URLQueryItem(name: "symbols", value: "usd")]
        
        // If this fail, it's because a programming error -> wrong URL
        guard let url = urlComponents.url else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error as NSError? {
                DispatchQueue.main.async {
                    then(.failure(.requestError(error)))
                }
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
            
            self.latestRateAndDate = LatestRateAndDate(usdRate: usdRate, requestDate: responseJSON.date)
            
            let usdValue = from * usdRate
            DispatchQueue.main.async {
                then(.success(usdValue))
            }
        })
        task.resume()
    }
    
    func wasRequestMadeToday(requestDate: String) -> Bool {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        return formattedDate == requestDate
    }
    
    func convertToDouble(from currency: String, locale: Locale) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = locale
        return numberFormatter.number(from: currency)?.doubleValue
    }
}

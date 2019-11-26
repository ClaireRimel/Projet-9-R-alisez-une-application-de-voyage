//
//  Weather.swift
//  LeBaluchon
//
//  Created by Claire on 12/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

class Weather {
    
    let session: RequestInterface
    
    let apiKey: String
    
    // Default argument in function
    init(session: RequestInterface = URLSession.shared,
         apiKey: String = APIKeys.weather) {
        self.session = session
        self.apiKey = apiKey
    }
    
    func request(from: String, then: @escaping (Result<LatestWeatherResponse, WeatherError>) -> Void) {
                
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        
        urlComponents.queryItems = [URLQueryItem(name: "q", value: from),
                                    URLQueryItem(name: "mode", value: "json"),
                                    URLQueryItem(name: "lang", value: "fr"),
                                    URLQueryItem(name: "units", value: "metric"),
                                    URLQueryItem(name: "APPID", value: apiKey)]
        
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
                let responseJSON = try? JSONDecoder().decode(LatestWeatherResponse.self, from: data) else {
                    DispatchQueue.main.async {
                        then(.failure(.invalidResponseFormat))
                    }
                    return
            }
            print(responseJSON)
            DispatchQueue.main.async {
                then(.success(responseJSON))
            }
        })
        task.resume()
    }
}

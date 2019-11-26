//
//  Translate.swift
//  LeBaluchon
//
//  Created by Claire on 07/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import UIKit

class Translation {
    
      let session: RequestInterface
      
      let apiKey: String
      
      // Default argument in function
      init(session: RequestInterface = URLSession.shared,
           apiKey: String = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_TRANSLATION_KEY") as! String) {
          self.session = session
          self.apiKey = apiKey
      }
    
    func request(from: String, then: @escaping (Result<String, TranslationError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        
        urlComponents.queryItems = [URLQueryItem(name: "q", value: from),
                                    URLQueryItem(name: "target", value: "en"),
                                    URLQueryItem(name: "format", value: "text"),
                                    URLQueryItem(name: "key", value: apiKey)]

        
        // If this fail, it's because a programming error -> wrong URL
        guard let url = urlComponents.url else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error as NSError? {
                DispatchQueue.main.async {
                    then(.failure(.requestError(error)))
                }
                return
            }
            
            guard let data = data,
                let responseJSON = try? JSONDecoder().decode(LatestTranslationResponse.self, from: data) else {
                    DispatchQueue.main.async {
                        then(.failure(.invalidResponseFormat))
                    }
                    return
            }
            print(responseJSON)
            
            DispatchQueue.main.async {
                then(.success(responseJSON.data.translations[0].translatedText))
            }
        })
        task.resume()
    }
}

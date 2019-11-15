//
//  WeatherError.swift
//  LeBaluchon
//
//  Created by Claire on 12/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case requestError(Error)
    case invalidResponseFormat
}

extension WeatherError {
    var message: String{
        switch self {
        case let .requestError(error):
            return error.localizedDescription
        case .invalidResponseFormat:
            return "Le format de réponse du serveur est invalide "
        }
    }
}

//
//  CurrencyConverterErrorModel.swift
//  LeBaluchon
//
//  Created by Claire on 01/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

//typed errors
enum CurrencyConverterError: Error, Equatable {
    case requestError(NSError)
    case invalidResponseFormat
    case usdRateNotFound
    case invalidInput
}

extension CurrencyConverterError {
    var message: String{
        switch self {
        case let .requestError(error):
            return error.localizedDescription
        case .invalidResponseFormat:
            return "Le format de réponse du serveur est invalide "
        case .usdRateNotFound:
            return "La devise USD n'est pas disponible"
        case .invalidInput:
            return "Entrez un montant valide"
        }
    }
}

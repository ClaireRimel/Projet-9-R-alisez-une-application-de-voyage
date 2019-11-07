//
//  TranslationError.swift
//  LeBaluchon
//
//  Created by Claire on 07/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

enum TranslationError: Error {
    case requestError(Error)
    case invalidResponseFormat
    case usdRateNotFound
    case invalidInput
}

extension TranslationError {
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

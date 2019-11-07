//
//  LatestTranslationResponse.swift
//  LeBaluchon
//
//  Created by Claire on 07/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation


struct LatestTranslationResponse: Codable {
    
    let data: DataResponse
}

struct DataResponse: Codable {
    
    let translations: [TranslatedTextResponse]
}

struct TranslatedTextResponse: Codable {

    let translatedText: String
}

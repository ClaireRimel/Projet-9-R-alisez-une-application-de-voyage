//
//  LatestCurrencyResponseModel.swift
//  LeBaluchon
//
//  Created by Claire on 01/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

struct LatestCurrencyResponse: Codable {
    
    let success: Bool
    let timestamp: Double
    let base: String
    let date: String
    let rates: [String: Double]
}

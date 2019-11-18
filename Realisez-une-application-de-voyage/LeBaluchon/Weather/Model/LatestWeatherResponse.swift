//
//  LatestWeatherResponse.swift
//  LeBaluchon
//
//  Created by Claire on 12/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

struct LatestWeatherResponse: Codable {
    let main: MainResponse
    let weather: [DescriptionResponse]
    let name: String
    let dt: TimeInterval
}

struct MainResponse: Codable {
    let temp: Double
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}

struct DescriptionResponse: Codable {
    let description: String
}

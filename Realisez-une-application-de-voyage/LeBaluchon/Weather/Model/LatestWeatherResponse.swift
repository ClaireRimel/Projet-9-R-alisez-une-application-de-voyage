//
//  LatestWeatherResponse.swift
//  LeBaluchon
//
//  Created by Claire on 12/11/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import Foundation

struct LatestWeatherResponse: Codable, Equatable {
    let main: MainResponse
    let weather: [DescriptionResponse]
    let dt: TimeInterval
}

struct MainResponse: Codable, Equatable {
    let temp: Double
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}

struct DescriptionResponse: Codable, Equatable {
    let description: String
}

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
    let pressure: Int
    let humidity: Int
}

struct DescriptionResponse: Codable {
    let description: String
}

struct sunRiseAndSet: Codable {
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

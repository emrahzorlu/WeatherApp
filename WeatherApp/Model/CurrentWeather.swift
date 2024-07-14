//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Emrah Zorlu on 14.07.2024.
//

import Foundation

struct CurrentWeather: Codable {
  let tempC: Float
  let condition: Condition

  enum CodingKeys: String, CodingKey {
    case tempC = "temp_c"
    case condition
  }
}

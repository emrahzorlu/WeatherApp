//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Emrah Zorlu on 14.07.2024.
//

import Foundation

struct WeatherResponse: Codable {
  let location: Location
  let current: CurrentWeather
  let forecast: Forecast
}

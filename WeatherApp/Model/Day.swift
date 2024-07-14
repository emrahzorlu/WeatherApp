//
//  Day.swift
//  WeatherApp
//
//  Created by Emrah Zorlu on 14.07.2024.
//

import Foundation

struct Day: Codable {
  let maxtempC: Double
  let mintempC: Double
  let condition: Condition

  private enum CodingKeys: String, CodingKey {
    case maxtempC = "maxtemp_c"
    case mintempC = "mintemp_c"
    case condition
  }
}

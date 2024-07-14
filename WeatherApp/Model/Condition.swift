//
//  Condition.swift
//  WeatherApp
//
//  Created by Emrah Zorlu on 14.07.2024.
//

import Foundation

struct Condition: Codable {
  let text: String
  let icon: String
  
  var iconURL: URL? {
    return URL(string: "https:" + icon)
  }
}

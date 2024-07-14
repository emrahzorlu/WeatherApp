//
//  City.swift
//  WeatherApp
//
//  Created by Emrah Zorlu on 14.07.2024.
//

import Foundation

struct City: Decodable {
  let id: Int
  let name: String
  let region: String
  let country: String
}

//
// DateExtension.swift
// WeatherApp
//
// Created by Emrah Zorlu on 12.07.2024.
//

import Foundation

extension String {
  func toDate(format: DateFormat) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue

    return dateFormatter.date(from: self)
  }
}

extension Date {
  func dayOfWeek() -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = DateFormat.dayOfWeek.rawValue

    return dateFormatter.string(from: self).capitalized
  }
}

//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by Emrah Zorlu on 12.07.2024.
//

import Foundation

class WeatherViewModel {
  private let weatherService: WeatherServiceProtocol
  var cities: [City] = []
  var weatherResponse: WeatherResponse?
  private var searchThrottle: Throttle?
  
  var onCitiesUpdated: (() -> Void)?
  var onWeatherFetched: (() -> Void)?
  
  init(weatherService: WeatherServiceProtocol = WeatherService()) {
    self.weatherService = weatherService
  }
  
  func searchCities(query: String) {
    searchThrottle?.cancel()
    searchThrottle = Throttle(minimumDelay: 0.3)
    searchThrottle?.throttle { [weak self]  in
      self?.weatherService.searchCities(query: query) { [weak self] result in
        switch result {
        case .success(let cities):
          self?.cities = cities
          self?.onCitiesUpdated?()
        case .failure(let error):
          print("Failed to search cities: \(error)")
        }
      }
    }
  }
  
  func fetchWeather(for city: String) {
    weatherService.fetchWeather(location: city, days: 14) { [weak self] result in
      switch result {
      case .success(let weatherResponse):
        self?.weatherResponse = weatherResponse
        self?.onWeatherFetched?()
      case .failure(let error):
        print("Failed to fetch weather details: \(error)")
      }
    }
  }
}

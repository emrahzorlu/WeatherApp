//
// NetworkService.swift
// WeatherApp
//
// Created by Emrah Zorlu on 10.07.2024.
//

import Foundation
import Alamofire

enum NetworkError: Error {
  case failure
}

protocol WeatherServiceProtocol {
  func fetchWeather(location: String, days: Int, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void)
  func searchCities(query: String, completion: @escaping (Result<[City], NetworkError>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
  private let apiKey = API.apiKey

  private func baseRequest<T: Decodable>(urlString: String, parameters: [String: Any], completion: @escaping (Result<T, NetworkError>) -> Void) {
    AF.request(urlString, parameters: parameters)
      .validate()
      .responseDecodable(of: T.self) { response in
        switch response.result {
        case .success(let data):
          completion(.success(data))
        case .failure(_):
          completion(.failure(.failure))
        }
      }
  }

  func fetchWeather(location: String, days: Int, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
    let parameters: [String: Any] = [
      API.ParameterKey.key.rawValue: apiKey,
      API.ParameterKey.query.rawValue: location,
      API.ParameterKey.days.rawValue: days
    ]
    let urlString = API.baseURL + API.Endpoint.forecast.rawValue
    baseRequest(urlString: urlString, parameters: parameters, completion: completion)
  }

  func searchCities(query: String, completion: @escaping (Result<[City], NetworkError>) -> Void) {
    let parameters: [String: Any] = [
      API.ParameterKey.key.rawValue: apiKey,
      API.ParameterKey.query.rawValue: query
    ]
    let urlString = API.baseURL + API.Endpoint.search.rawValue
    baseRequest(urlString: urlString, parameters: parameters, completion: completion)
  }
}

//
//  ServiceEnum.swift
//  WeatherApp
//
//  Created by Emrah Zorlu on 14.07.2024.
//

enum API {
    static let baseURL = "https://api.weatherapi.com/v1"
    static let apiKey = "e4cd0963cf7e4bb79af131410241007"

    enum Endpoint: String {
        case forecast = "/forecast.json"
        case search = "/search.json"
    }

    enum ParameterKey: String {
        case key
        case query = "q"
        case days
    }
}

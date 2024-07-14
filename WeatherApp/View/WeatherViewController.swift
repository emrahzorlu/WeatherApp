//
//  WeatherMainViewController.swift
//  WeatherApp
//
//  Created by Emrah Zorlu on 11.07.2024.
//

import UIKit
import Kingfisher

class WeatherViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var detailStackView: UIStackView!

  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var conditionTextLabel: UILabel!
  @IBOutlet weak var minTempLabel: UILabel!
  @IBOutlet weak var maxTempLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!

  var viewModel = WeatherViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.isPagingEnabled = true

    viewModel.onCitiesUpdated = { [weak self] in
      self?.tableView.reloadData()
    }

    viewModel.onWeatherFetched = { [weak self] in
      DispatchQueue.main.async {
        self?.updateWeatherDetails()
      }
    }
  }

  func updateWeatherDetails() {
    guard let weatherResponse = viewModel.weatherResponse else { return }
    cityNameLabel.text = weatherResponse.location.name
    temperatureLabel.text = "\(Int(round(weatherResponse.current.tempC)))°"
    conditionTextLabel.text = weatherResponse.current.condition.text
    conditionImageView.kf.setImage(with: weatherResponse.current.condition.iconURL, placeholder: UIImage(named: PlaceholderImage.default.rawValue))
    minTempLabel.text = "\(Int(round(weatherResponse.forecast.forecastday.first?.day.mintempC ?? 0)))°"
    maxTempLabel.text = "\(Int(round(weatherResponse.forecast.forecastday.first?.day.maxtempC ?? 0)))°"

    collectionView.reloadData()
    detailStackView.isHidden = false
  }
}

extension WeatherViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    detailStackView.isHidden = true
    if searchText.count >= 3 {
      tableView.isHidden = false
      viewModel.searchCities(query: searchText)
      collectionView.contentOffset = .zero
    } else {
      viewModel.cities = []
      tableView.reloadData()
    }
  }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.cities.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.cityCell.rawValue, for: indexPath)
    let city = viewModel.cities[indexPath.row]
    cell.textLabel?.text = city.name

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCity = viewModel.cities[indexPath.row]
    viewModel.fetchWeather(for: selectedCity.name)
    tableView.isHidden = true
  }
}

extension WeatherViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.weatherResponse?.forecast.forecastday.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.weatherCell.rawValue, for: indexPath) as! WeatherCollectionViewCell
    if let forecast = viewModel.weatherResponse?.forecast.forecastday[indexPath.item] {
      cell.configure(with: forecast)
    }

    return cell
  }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfItemsPerPage: CGFloat = 4
    let itemWidth = collectionView.bounds.width / numberOfItemsPerPage
    let itemHeight = collectionView.bounds.height

    return CGSize(width: itemWidth, height: itemHeight)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Emrah Zorlu on 12.07.2024.
//

import UIKit
import Kingfisher

class WeatherCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var minTempLabel: UILabel!
  @IBOutlet var maxTempLabel: UILabel!
  
  func configure(with model: ForecastDay) {
    minTempLabel.text = "\(Int(round((model.day.mintempC))))°"
    maxTempLabel.text = "\(Int(round(model.day.maxtempC)))°"
    imageView.kf.setImage(with: model.day.condition.iconURL, placeholder: UIImage(named: PlaceholderImage.default.rawValue))
    if let date = model.date.toDate(format: DateFormat.standard),
       let dayOfWeek = date.dayOfWeek() {
      dateLabel.text = dayOfWeek
    } else {
      dateLabel.text = "N/A"
    }
  }
}

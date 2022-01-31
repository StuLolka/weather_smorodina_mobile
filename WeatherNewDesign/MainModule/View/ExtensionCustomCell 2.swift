//
//  ExtensionCustomCell.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 18.08.2021.
//

import UIKit
extension CustomCellWeatherTableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherModel?.dateArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.idCell, for: indexPath) as? CustomCollectionCell else {
            print("cell error")
            return UICollectionViewCell()}
        guard let weatherModel = weatherModel else {
            print("weatherModel error")
            return UICollectionViewCell()
        }
        cell.backgroundColor = Theme.currentTheme.collectionCellBack
        cell.timeLabel.text = getTime(model: weatherModel, i: indexPath)
        
        
        
        cell.weatherImageView.image = WeatherImage.returnImage(main: weatherModel.mainArray[indexPath.row], description: weatherModel.descriptionArray[indexPath.row], rain: cell.imageRainWeatherMiniView, sun: cell.imageSunWeatherMiniView)

        cell.temperatureLabel.text = weatherModel.temeratureArray[indexPath.row] + "°"
        cell.layer.cornerRadius = cell.bounds.height / 7.125
        
        cell.temperatureLabel.textColor = Theme.currentTheme.text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width / 4.69, height: bounds.height / 1.8)
    }
    
    private func getTime(model: WeatherData, i: IndexPath) -> String {
        let dateAndTimeSplit = model.dateArray[i.row].split(separator: " ")
        let time = dateAndTimeSplit[1].split(separator: ":")
        return String(time[0]) + ":" + String(time[1])
    }
}

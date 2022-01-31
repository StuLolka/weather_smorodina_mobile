//
//  ExtensionCustomCell.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 18.08.2021.
//

import UIKit
extension CustomCellWeatherTableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherModelForCell.weatherData?.dateArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.idCell, for: indexPath) as? CustomCollectionCell else {
            print("cell error")
            return UICollectionViewCell()}
        guard var weatherModel = WeatherModelForCell.weatherData else {
            print("weatherModel error")
            return UICollectionViewCell()
        }
        cell.backgroundColor = Theme.currentTheme.collectionCellBack
        cell.timeLabel.text = DateTime.getArrayTimeForCell(dateArray: weatherModel.dateArray, i: indexPath.row)
        
        if let getMainModel = ArrayExtension.getElementFromArray(indexPath.row, &weatherModel.mainArray), let getDescriptionModel = ArrayExtension.getElementFromArray(indexPath.row, &weatherModel.descriptionArray) {
            cell.weatherImageView.image = WeatherImage.returnImage(main: getMainModel, description: getDescriptionModel, rain: cell.imageRainWeatherMiniView, sun: cell.imageSunWeatherMiniView)
        }
        cell.temperatureLabel.text = weatherModel.temeratureArray[indexPath.row].addDegreeSymbol()
        cell.layer.cornerRadius = cell.bounds.height / 7.125
        
        cell.temperatureLabel.textColor = Theme.currentTheme.text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width / 4.69, height: bounds.height / 1.8)
    }
}

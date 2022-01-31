//
//  ExtensionWeatherView.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit

extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fillWeatherArray()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        view.bounds.height / 156.26
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellWeatherTableView.idCell, for: indexPath) as? CustomCellWeatherTableView else {return UITableViewCell()}
        WeatherModelForCell.weatherData = MainWeatherArray.modelWeatherDataArray[indexPath.section]
        cell.selectionStyle = .none
        cell.backgroundColor = Theme.currentTheme.cellBackground
        cell.line.backgroundColor = Theme.currentTheme.line
        
        cell.dateLabel.textColor = Theme.currentTheme.text
        cell.dateLabel.attributedText = attributeString(date: MainWeatherArray.modelWeatherDataArray[indexPath.section].date, dayOfWeek: MainWeatherArray.modelWeatherDataArray[indexPath.section].dayOfWeek ?? "")
        
        cell.firstTemperatureLabel.text = MainWeatherArray.modelWeatherDataArray[indexPath.section].temp_max.addDegreeSymbol()
        cell.secondTemperatureLabel.text = MainWeatherArray.modelWeatherDataArray[indexPath.section].temp_min.addDegreeSymbol()
        cell.weatherImageView.image = WeatherImage.returnImage(main: MainWeatherArray.modelWeatherDataArray[indexPath.section].main, description: MainWeatherArray.modelWeatherDataArray[indexPath.section].description, rain: cell.rainWeatherImageView, sun: cell.sunWeatherImageView)
        
        cell.weatherCollectionView.backgroundColor = Theme.currentTheme.cellBackground
        cell.weatherCollectionView.reloadData()
        
        
        cell.layer.cornerRadius = view.bounds.height / 25
        cell.clipsToBounds = true
        cell.setFonts(view: view)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var i = 0
        var timeArray = [String]()
        guard let modelWeatherDataArray = ArrayExtension.getElementFromArray(indexPath.section, &MainWeatherArray.modelWeatherDataArray) else {return }
        while i < modelWeatherDataArray.dateArray.count {
            timeArray.append(DateTime.getTimeWithoutSeconds(date: MainWeatherArray.modelWeatherDataArray[indexPath.section].dateArray[i]))
            i += 1
        }
        
        guard let modelWeatherData = ArrayExtension.getElementFromArray(indexPath.section, &MainWeatherArray.modelWeatherDataArray) else {return }
        let modelWeatherList = ModelWeatherList(main: modelWeatherData.main,
                                                description: modelWeatherData.description,
                                                wind: modelWeatherData.wind,
                                                pressure: modelWeatherData.pressure,
                                                temp_max: modelWeatherData.temp_max,
                                                image: modelWeatherData.image,
                                                temp_min: modelWeatherData.temp_min,
                                                feelsLike: modelWeatherData.feelsLike,
                                                humidity: modelWeatherData.humidity,
                                                precipitation: modelWeatherData.precipitation)
        
        
        let model = CityModelData(cityName: modelWeatherData.cityName,
                                  date: modelWeatherData.date,
                                  modelWeatherList: modelWeatherList,
                                  dateArray: timeArray,
                                  temeratureArray: modelWeatherData.temeratureArray)
        guard let image = mainViews.miniView.image else { fatalError("No image") }
        router.openCityScreen(cityModelData: model, image: image, delegate: self)
    }
    
    private func fillWeatherArray() -> Int {
        presenter?.updateMainWeatherArray()
        return  MainWeatherArray.modelWeatherDataArray.count
    }
    
    //MARK: - attributed date string
    private func attributeString(date: String, dayOfWeek: String) -> NSAttributedString? {
        
        let attributedString = NSMutableAttributedString(string: date)
        guard let range = getRangeOfSubString(subString: dayOfWeek, fromString: date) else {
            print("No range")
            return nil}
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], range: range)
        return attributedString
    }
    
    private func getRangeOfSubString(subString: String, fromString: String) -> NSRange? {
        guard let sampleLinkRange = fromString.range(of: subString) else {return nil}
        let startPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.lowerBound)
        let endPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.upperBound)
        let linkRange = NSMakeRange(startPos, endPos - startPos)
        return linkRange
    }
}

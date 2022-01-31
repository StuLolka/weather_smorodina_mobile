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
        cell.weatherModel = weatherArray[indexPath.section]
        cell.selectionStyle = .none
        cell.backgroundColor = Theme.currentTheme.cellBackground
        cell.line.backgroundColor = Theme.currentTheme.line
        
        cell.dateLabel.text = weatherArray[indexPath.section].date
        cell.firstTemperatureLabel.text = weatherArray[indexPath.section].temperature + "°"
        cell.secondTemperatureLabel.text = weatherArray[indexPath.section].temp_max + "°"
        
        //        print("description = \(weatherArray[indexPath.section].)")
        cell.weatherImageView.image = WeatherImage.returnImage(main: weatherArray[indexPath.section].main, description: weatherArray[indexPath.section].description, rain: cell.imageRainWeatherMiniView, sun: cell.imageSunWeatherMiniView)
        
        cell.weatherCollectionView.backgroundColor = Theme.currentTheme.cellBackground
        cell.weatherCollectionView.reloadData()
        
        
        cell.layer.cornerRadius = view.bounds.height / 25
        cell.clipsToBounds = true
        cell.setFonts(view: view)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ModuleBuilder.CityModule(model: weatherArray[indexPath.section])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fillWeatherArray() -> Int {
        guard let modelWeather = modelWeather else {return 0}
        weatherArray = []
        let firstDateAndTimeSplit = modelWeather.list[0].dt_txt.split(separator: " ")
        let firstDateSplit = firstDateAndTimeSplit[0].split(separator: "-")
        var day = firstDateSplit[2]
        
        var i = 0
        var j = -1
        while(i < modelWeather.list.count) {
            
            
            let dateAndTimeSplit = modelWeather.list[i].dt_txt.split(separator: " ")
            let dateSplit = dateAndTimeSplit[0].split(separator: "-")
            if i == 0 || day != dateSplit[2] {
                weatherArray.append(WeatherData(cityName: modelWeather.city.name,
                                                date: String(dateSplit[2]) + "." + String(dateSplit[1]),
                                                main: modelWeather.list[i].weather[0].main,
                                                description: modelWeather.list[i].weather[0].description,
                                                wind: String(Int(modelWeather.list[i].wind.speed)),
                                                pressure: String(modelWeather.list[i].main.pressure),
                                                temperature: String(Int(modelWeather.list[i].main.temp)),
                                                image: modelWeather.list[i].weather[0].icon,
                                                temp_max: String(Int(modelWeather.list[i].main.temp_max)),
                                                feelsLike: String(Int(modelWeather.list[i].main.feels_like)),
                                                humidity: String(modelWeather.list[i].main.humidity),
                                                precipitation: String(Int(modelWeather.list[i].pop))))
                day = dateSplit[2]
                j += 1
            }
            if j == 0 && isHourSame(dateInModel: modelWeather.list[i].dt_txt) {
                i += 1
                continue
            }
            
            weatherArray[j].dateArray.append(modelWeather.list[i].dt_txt)
            weatherArray[j].temeratureArray.append(String(Int(modelWeather.list[i].main.temp)))
            weatherArray[j].iconArray.append(modelWeather.list[i].weather[0].icon)
            weatherArray[j].mainArray.append(modelWeather.list[i].weather[0].main)
            weatherArray[j].descriptionArray.append(modelWeather.list[i].weather[0].description)
            i += 1
        }
        return weatherArray.count
    }
    
    private func isHourSame(dateInModel: String) -> Bool {
        let date = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: date)
        var dateInModel = dateInModel
        dateInModel.removeFirst(11)
        dateInModel.removeLast(6)
        guard let hourInModel = Int(dateInModel) else {
            return false
        }
        if currentHour >= hourInModel {
            return true
        }
        else {
            return false
        }
    }
}

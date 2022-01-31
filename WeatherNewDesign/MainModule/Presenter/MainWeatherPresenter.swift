//
//  MainWeatherPresenter.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import Foundation
import UIKit
import CoreLocation
import NeedleFoundation

protocol WeatherPresenterDependency: Dependency {
    var network: NetworkProtocol { get }
    var location: LocationFacadeProtocol {get }
}

class WeatherPresenterComponent: Component<WeatherPresenterDependency> {
    func weatherPresenter() -> WeatherPresenterProtocol {
        return WeatherPresenter(network: dependency.network, location: dependency.location)
    }
}

protocol WeatherViewProtocol: UIViewController {
    var presenter: WeatherPresenterProtocol? {get set}
    
    func addDataToView(from model: WeatherModel, with date: String)
    func setProgress(loading: Float)
    func endRefreshing()
    func pushToCityView(cityModelData: CityModelData)
}

final class WeatherPresenter: WeatherPresenterProtocol {

    private lazy var dateInCurrentCity: String = {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }()
    
    weak var view: WeatherViewProtocol?
    private var network: NetworkProtocol
    private var location: LocationFacadeProtocol
    
    private var weatherModelHolder: WeatherModel?
    
    private lazy var currentLocationWeatherByIP = {
        self.network.fetchCurrentLocationWeatherByIP { (city) in
            self.loadDataCurrentCity(city: city.city)
        }
    }
    
    init(network: NetworkProtocol, location: LocationFacadeProtocol) {
        self.network = network
        self.location = location
    }
    
    
    func loadDataCurrentCity(city: String) {
    
        self.network.fetchWeather(city: city, language: "en") { model in
            self.weatherModelHolder = model
            guard let model = self.weatherModelHolder else {return }
            self.addDataToViewController(model: model)
        }loading: { loading in
            self.view?.setProgress(loading: loading)
        }
    }
    
    func getCurrentLocationUser() {
        network.currentLocationWeatherByIP = currentLocationWeatherByIP
        location.delegate = self
        location.getLocation()
    }
    
    
    func getCurrentLocationWeatherByIP() {
        self.network.fetchCurrentLocationWeatherByIP { (city) in
            self.loadDataCurrentCity(city: city.city)
        }
    }
    
    func getCityName() -> String? {
        if let city = weatherModelHolder?.city.name {
            return city
        }
        return nil
    }
    
    func setCityModelData(date: String) {
        guard var modelWeather = weatherModelHolder else {
            return 
        }
        var i = 0
        var timeArray = [String]()
        var tempArray = [String]()
        while i < 9 {
            guard let listModelWeather = ArrayExtension.getElementFromArray(i, &modelWeather.list) else {return }
            timeArray.append(listModelWeather.dt_txt)
            tempArray.append(String(listModelWeather.main.temp_max))
            i += 1
        }
        guard var list = ArrayExtension.getElementFromArray(0, &modelWeather.list) else {return }
        guard let weather = ArrayExtension.getElementFromArray(0, &list.weather) else {return }
        
        let modelWeatherList = ModelWeatherList(main: weather.main,
                                                description: weather.description,
                                                wind: String(Int(list.wind.speed)),
                                                pressure: String(list.main.pressure),
                                                temp_max: String(Int(list.main.temp_max)),
                                                image: weather.icon,
                                                temp_min: String(Int(list.main.temp_min)),
                                                feelsLike: String(Int(list.main.feels_like)),
                                                humidity: String(list.main.humidity),
                                                precipitation: String(Int(list.pop)))
        
        let model = CityModelData(cityName: modelWeather.city.name,
                             date: date,
                             modelWeatherList: modelWeatherList,
                             dateArray: timeArray,
                             temeratureArray: tempArray)
        
        view?.pushToCityView(cityModelData: model)
    }
    
    func getWeather(city: String) {
        self.network.fetchWeather(city: city, language: "en") { model in
            self.weatherModelHolder = model
            guard let model = self.weatherModelHolder else {return }
            self.addDataToViewController(model: model) 
            DispatchQueue.main.async {
                self.view?.endRefreshing()
            }
        }loading: { loading in
            
        }
    }
    
    private func addDataToViewController(model: WeatherModel) {
            if let timezone = TimeZone(secondsFromGMT: model.city.timezone) {
                self.dateInCurrentCity = Date().toLocalTime(timezone: timezone)
            }
        view?.addDataToView(from: model, with: dateInCurrentCity)
    }
    
    func updateMainWeatherArray() {
        MainWeatherArray.modelWeatherDataArray = []
        
        guard let modelWeather = weatherModelHolder else { return }
        guard var day = getDay(modelWeather: modelWeather) else { return }
        
        var i = 0
        var j = -1
        while(i < modelWeather.list.count) {
            var dateAndTimeSplit = modelWeather.list[i].dt_txt.split(separator: " ")
            guard let dateAndTimeSplitZero = ArrayExtension.getElementFromArray(0, &dateAndTimeSplit) else { return }
            var dateSplit = dateAndTimeSplitZero.split(separator: "-")
            guard var dateSplitSecond = ArrayExtension.getElementFromArray(2, &dateSplit) else { return }
            
            if dateSplitSecond.first == "0" {
                dateSplitSecond.removeFirst()
            }
            let mounth = DateTime.getMonthName(String(dateAndTimeSplit[0]))
            let dayOfWeek = DateTime.getDayOfWeek(String(dateAndTimeSplit[0]))
            
            if i == 0 || day != dateSplit[2] {
                
                MainWeatherArray.modelWeatherDataArray.append(WeatherData(cityName: modelWeather.city.name,
                                                                          date: String(dateSplitSecond) + " " + mounth + ", " + dayOfWeek,
                                                                          dayOfWeek: dayOfWeek,
                                                                          main: modelWeather.list[i].weather[0].main,
                                                                          description: modelWeather.list[i].weather[0].description,
                                                                          wind: String(Int(modelWeather.list[i].wind.speed)),
                                                                          pressure: String(modelWeather.list[i].main.pressure),
                                                                          temp_max: String(Int(modelWeather.list[i].main.temp_max)),
                                                                          image: modelWeather.list[i].weather[0].icon,
                                                                          temp_min: String(Int(modelWeather.list[i].main.temp_min)),
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
            guard ArrayExtension.getElementFromArray(j, &MainWeatherArray.modelWeatherDataArray) != nil else { return }
            fillMainWeatherArray(index: j, index: i, modelWeather: modelWeather)
            i += 1
        }
    }
    
    private func getDay(modelWeather: WeatherModel) -> Substring.SubSequence? {
        var modelWeather = modelWeather
        guard let modelListZero = ArrayExtension.getElementFromArray(0, &modelWeather.list) else { return nil}
        var firstDateAndTimeSplit = modelListZero.dt_txt.split(separator: " ")
        guard let firstDateAndTimeSplitZero = ArrayExtension.getElementFromArray(0, &firstDateAndTimeSplit) else { return nil}
        var firstDateSplit = firstDateAndTimeSplitZero.split(separator: "-")
        return  ArrayExtension.getElementFromArray(2, &firstDateSplit)
    }
    
    private func fillMainWeatherArray(index j: Int, index i: Int, modelWeather: WeatherModel) {
        MainWeatherArray.modelWeatherDataArray[j].dateArray.append(modelWeather.list[i].dt_txt)
        MainWeatherArray.modelWeatherDataArray[j].temeratureArray.append(String(Int(modelWeather.list[i].main.temp_max)))
        MainWeatherArray.modelWeatherDataArray[j].iconArray.append(modelWeather.list[i].weather[0].icon)
        MainWeatherArray.modelWeatherDataArray[j].mainArray.append(modelWeather.list[i].weather[0].main)
        MainWeatherArray.modelWeatherDataArray[j].descriptionArray.append(modelWeather.list[i].weather[0].description)
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


extension WeatherPresenter: NetworkDelegate {
    func getData(from coordinate: CLLocationCoordinate2D) {
        self.network.fetchCurrentLocationWeather(lat: coordinate.latitude, lon: coordinate.longitude) { currentCity in
            self.loadDataCurrentCity(city: currentCity.name)
        }
    }
    
    func getDataFromIP() {
        getCurrentLocationWeatherByIP()
    }
}

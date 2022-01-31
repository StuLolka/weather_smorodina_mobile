//
//  CityPresenter.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 31.08.2021.
//
import NeedleFoundation

protocol CityWeatherProtocol: UIViewController {
    func addDataToLabel(model: CityModelData)
    func setData()
}

class CityPresenterComponent: Component<EmptyDependency> {
    func cityPresenter() -> CityPresenterProtocol {
        return CityPresenter()
    }
}

final class CityPresenter: CityPresenterProtocol {
    
    var view: CityWeatherProtocol?
    var cityModelData: CityModelData?
    
    func getData() {
        guard let data = cityModelData else {return }
        view?.addDataToLabel(model: data)
    }
    
    func getTimeAndTemp() {
        guard let tempArray = cityModelData?.temeratureArray else {return }
        guard let timeArray = cityModelData?.dateArray else {return }
        TimeAndTemperatureData.data = TimeAndTemperature(time: timeArray, temperature: tempArray)
        view?.setData()
    }
}

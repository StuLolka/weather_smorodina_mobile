//
//  CityWeather.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 17.08.2021.
//

import UIKit
import Charts

protocol CityPresenterProtocol {
    var view: CityWeatherProtocol? {get set}
    var cityModelData: CityModelData? {get set}
    
    func getData()
    func getTimeAndTemp()
}

class CityWeatherController: UIViewController, CityWeatherProtocol {
    private let router = Router.shared
    var delegate: MainWeatherViewController?
    
    var presenter: CityPresenterProtocol?
    //    MARK:- views
    private let cityViews = CityViews()
    
    //    MARK:- fonts
    private lazy var bigFont = UIFont.boldSystemFont(ofSize: cityViews.miniView.bounds.height / 18)
    private lazy var littleFont = UIFont.systemFont(ofSize: cityViews.miniView.bounds.height / 26)
    private lazy var middleFont = UIFont.systemFont(ofSize: cityViews.miniView.bounds.height / 20)
    
    //    MARK:- back miniview image
    var backImage: UIImage?
    
    //    MARK:- Line Chart
    private lazy var lineChartView: LineChartView = {
        guard let timeArray = TimeAndTemperatureData.data?.timeArray else {return LineChartView()}
        let line = cityViews.lineChartView
        line.delegate = self
        let customFormater = CustomFormatter()
        line.clipsToBounds = true
        if timeArray.count < 6 {
            line.xAxis.labelCount = timeArray.count
        }
        else {
            line.xAxis.labelCount = 6
        }
        customFormater.labels = timeArray
        
        line.xAxis.valueFormatter = customFormater
        line.xAxis.labelFont = .systemFont(ofSize: 15)
        line.xAxis.spaceMin = 0.5
        line.xAxis.spaceMax = 0.5
        return line
    }()
    
    //    MARK:- closures
    private lazy var popViewController = {
        self.router.popViewController()
        return
    }
    private lazy var enterCity =  {
        guard let delegate = self.delegate else { fatalError() }
        self.router.openSearchScreen(delegate: delegate)
    }
    
    private lazy var changeTheme = {
        Theme.changeTheme()
        self.updateTheme()
    }
    
    //    MARK:- init
    init(presenter: CityPresenterProtocol, delegate: MainWeatherViewController) {
        self.presenter = presenter
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.presenter = nil
        self.delegate = nil
    }
    
    override func loadView() {
        self.view = cityViews
        self.view.bounds = UIScreen.main.bounds
        cityViews.setViews(with: navigationItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityViews.addBackButtonAction(popViewController)
        cityViews.addEnterCityAction(enterCity)
        cityViews.addChangeThemeAction(changeTheme)
        
        presenter?.getTimeAndTemp()
        
        cityViews.setMiniViewBackgraund(with: backImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTheme()
        presenter?.getData()
    }
    
    override func viewDidLayoutSubviews() {
        //    MARK:- set miniView
        cityViews.miniView.layer.cornerRadius = cityViews.miniView.bounds.height / 11.66
        lineChartView.layer.cornerRadius = lineChartView.bounds.height / 10.08
        
        //    MARK:- font
        cityViews.dateMiniViewLabel.font = middleFont
        cityViews.temperatureMiniViewLabel.font = .boldSystemFont(ofSize: cityViews.miniView.bounds.height / 5.8)
        cityViews.feelsLikeMiniViewLabel.font = middleFont
        cityViews.windTextMiniViewLabel.font = littleFont
        cityViews.humidityTextMiniViewLabel.font = littleFont
        cityViews.precipitationMiniViewTextLabel.font = littleFont
        cityViews.windRateMiniViewLabel.font = bigFont
        cityViews.humidityRateMiniViewLabel.font = bigFont
        cityViews.precipitationRateMiniViewLabel.font = bigFont
    }
    
    func addDataToLabel(model data: CityModelData) {
        title = data.cityName
        cityViews.dateMiniViewLabel.text = data.date
        cityViews.imageWeatherMiniView.image = WeatherImage.returnImage(main: data.modelWeatherList.main, description: data.modelWeatherList.description, rain: cityViews.imageRainWeatherMiniView, sun: cityViews.imageSunWeatherMiniView)
        cityViews.temperatureMiniViewLabel.text = data.modelWeatherList.temp_max.addDegreeSymbol()
        cityViews.feelsLikeMiniViewLabel.text = "\(data.modelWeatherList.description), feels like \(data.modelWeatherList.feelsLike)".addDegreeSymbol()
        cityViews.windRateMiniViewLabel.text = "\(data.modelWeatherList.wind) m/c"
        cityViews.humidityRateMiniViewLabel.text = "\(data.modelWeatherList.humidity)%"
        cityViews.precipitationRateMiniViewLabel.text = "\(data.modelWeatherList.precipitation)%"
    }
    
    private func updateTheme() {
        view.backgroundColor = Theme.currentTheme.background
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.background
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.text ?? .black]
        
        cityViews.updateTheme()
        lineChartView.backgroundColor = Theme.currentTheme.chartsBack
    }
    
    private func getChartDataEntry() -> [ChartDataEntry] {
        
        guard let timeArray = TimeAndTemperatureData.data?.timeArray else {return []}
        guard var temperatureArray = TimeAndTemperatureData.data?.temperatureArray else {return []}
        
        var yValues: [ChartDataEntry] = []
        var i = 0
        while i < timeArray.count && i < temperatureArray.count && i < 6 {
            guard let yString = ArrayExtension.getElementFromArray(i, &temperatureArray) else {return []}
            guard let y = Double(yString) else {return []}
            yValues.append(ChartDataEntry(x: Double(i), y: y))
            
            i += 1
        }
        return yValues
    }
}

extension CityWeatherController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        cityViews.markerView.refreshContent(entry: entry, highlight: highlight)
        chartView.marker = cityViews.markerView
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: getChartDataEntry(), label: nil)
        set1.mode = .cubicBezier
        set1.lineWidth = 4
        set1.setColor(UIColor(named: "Chart") ?? .systemBlue)
        set1.circleRadius = 5
        
        set1.drawValuesEnabled = false
        set1.circleHoleColor = .white
        set1.circleColors = [.systemBlue]
        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
    }
}



final class CustomFormatter: IAxisValueFormatter {
    
    var labels: [String] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let count = self.labels.count
        
        guard let axis = axis, count > 0 else {
            return ""
        }
        
        let factor = axis.axisMaximum / Double(count)
        
        let index = Int((value / factor).rounded())
        
        if index >= 0 && index < count {
            let date = labels[index].split(separator: " ")
            var time = self.labels[index]
            if date.count == 2 {
                time = DateTime.getTimeWithoutSeconds(date: self.labels[index])
            }
            return time
        }
        return ""
    }
}


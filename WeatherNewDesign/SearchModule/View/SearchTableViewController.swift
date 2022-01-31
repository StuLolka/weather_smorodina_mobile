//
//  SearchTableViewController.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit

protocol SearchDelegate {
    func updateCity(with name: String)
}

protocol SearchPresenterProtocol {
    var view: SearchTableViewProtocol? {get set}
    
    func loadDataCity(city: String)
}

final class SearchTableViewController: UITableViewController, SearchTableViewProtocol {
    
    private let router = Router.shared
    var weatherViewController: MainWeatherViewController?
    var observer: SearchDelegate?
    
    var presenter: SearchPresenterProtocol?
    
    lazy var tableViews = TableViews()
    
    
    //MARK:- closures
    private lazy var getUserLocation = {
        self.router.openMapScreen()
    }
    private lazy var popViewController = {
        self.router.popViewController()
        return
    }
    private lazy var changeTheme = {
        Theme.changeTheme()
        self.updateTheme()
    }
    private lazy var addCity = {
        self.tableViews.popUpView.isHidden = false
        self.tableViews.popUpView.textField.backgroundColor = Theme.currentTheme.textFieldBack
        self.tableViews.popUpView.cancelButton.backgroundColor = Theme.currentTheme.cellBackground
        self.tableViews.popUpView.addButton.backgroundColor = UIColor(named: "addCityBack")
        self.tableView.reloadData()
        self.tableView.backgroundColor = UIColor(named: "tableViewBackPopUpView")
        self.tableViews.popUpView.isUserInteractionEnabled = true
        self.tableViews.popUpView.textField.isUserInteractionEnabled = true
        self.tableViews.popUpView.textField.becomeFirstResponder()
        self.tableViews.popUpView.textField.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tableViews.popUpView.cancelButton.addTarget(self, action: #selector(self.closePopUpView), for: .touchUpInside)
        self.tableViews.popUpView.addButton.addTarget(self, action: #selector(self.addNewCity), for: .touchUpInside)
    }
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.presenter = nil
    }
    
    override func loadView() {
        self.tableView = tableViews
        self.tableView.bounds = UIScreen.main.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My cities"
        
        tableViews.searchDelegate = self
        tableViews.setConstraints()
        tableViews.addBackButtonAction(popViewController)
        tableViews.addCityAction(addCity)
        tableViews.addUserLocationAction(getUserLocation)
        tableViews.addChangeThemeAction(changeTheme)
        tableViews.createBackButton(navigationItem: navigationItem)
        
        navigationItem.rightBarButtonItem = nil
        tableView.register(SearchedCityTableViewCell.self, forCellReuseIdentifier: "Id")
        tableView.separatorStyle = .none
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        tableViews.setViews(navigationItem: navigationItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        reloadData()
        updateTheme()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        view.bounds.height / 83.375
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 11.11
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherModelListSearchedCities.searchedCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Id", for: indexPath) as? SearchedCityTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.setFonts(view: tableView)
        if tableViews.popUpView.isHidden {
            cell.setCell(isHidden: true)
            tableView.isScrollEnabled = true
        }
        else {
            cell.setCell(isHidden: false)
            tableView.isScrollEnabled = false
        }
        
        guard var weatherModel = ArrayExtension.getElementFromArray(indexPath.row, &WeatherModelListSearchedCities.searchedCities) else {return UITableViewCell()}
        guard var list = ArrayExtension.getElementFromArray(0, &weatherModel.list) else {return UITableViewCell()}
        guard let weather = ArrayExtension.getElementFromArray(0, &list.weather) else {return UITableViewCell()}
        cell.cityNameLabel.text = weatherModel.city.name
        cell.firstTemperatureLabel.text = String(Int(list.main.temp_max)).addDegreeSymbol()
        cell.secondTemperatureLabel.text = String(Int(list.main.temp_min)).addDegreeSymbol()
        cell.weatherImageView.image = WeatherImage.returnImage(main: weather.main, description: weather.description, rain: cell.rainWeatherImageView, sun: cell.sunWeatherImageView)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = ArrayExtension.getElementFromArray(indexPath.row, &WeatherModelListSearchedCities.searchedCities) else {return }
        observer?.updateCity(with: model.city.name)
        router.popToRootViewController()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            WeatherModelListSearchedCities.searchedCities.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
        tableViews.activityIndicator.stopAnimating()
    }
    
    func setProgress() {
        self.tableViews.activityIndicator.startAnimating()
    }
    
    func returnDefaultStyle() {
        tableViews.popUpView.isHidden = true
        tableViews.popUpView.endEditing(true)
        tableViews.popUpView.textField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.isUserInteractionEnabled = true
        tableView.reloadData()
        tableView.backgroundColor = Theme.currentTheme.background
    }
    
    func reloadDataCollection() {
        tableViews.popUpView.cityHintCollectionView.reloadData()
    }
    
    private func updateTheme() {
        tableView.reloadData()
        
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.background
        
        tableViews.updateTheme()
        tableViews.popUpView.updateTheme()
        
        tableViews.locationButton.backgroundColor = Theme.currentTheme.navigationItemBack
        tableViews.locationButton.tintColor = Theme.currentTheme.navigationItemTint
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.text ?? .black]
        view.backgroundColor = Theme.currentTheme.background
    }
    
    //MARK:- objc func
    @objc func closePopUpView() {
        returnDefaultStyle()
    }
    
    @objc func addNewCity() {
        guard let city = tableViews.popUpView.textField.text else {
            print("city text field error")
            return
        }
        presenter?.loadDataCity(city: city)
        returnDefaultStyle()
        tableView.reloadData()
    }
}

extension SearchTableViewController: UITableViewDropDelegate, UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let reorderedRow = WeatherModelListSearchedCities.searchedCities.remove(at: sourceIndexPath.row)
        WeatherModelListSearchedCities.searchedCities.insert(reorderedRow, at: destinationIndexPath.row)
    }
}

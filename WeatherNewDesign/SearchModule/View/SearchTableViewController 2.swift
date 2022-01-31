//
//  SearchTableViewController.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit

final class SearchTableViewController: UITableViewController {
    
    internal var weatherViewController: MainWeatherViewController?
    private let miniViews = SameViews()
    private lazy var backButton = miniViews.backButton
    
    internal var presenter: SearchPresenter? = nil
    internal let network = Network()
    
    var weatherModelArray: [WeatherModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                WeatherModelArray.weatherModelArray = self.weatherModelArray
            }
        }
    }
    
    
    internal lazy var popUpView: PopUpView = {
        let view = PopUpView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.currentTheme.textFieldBack
        return view
    }()
    
    private lazy var changeThemeButton: UIBarButtonItem = {
        let changeThemeButton = UIBarButtonItem(image: UIImage(systemName: "sun.min"), style: .done, target: self, action: #selector(changeTheme))
        return changeThemeButton
    }()
    
    private lazy var addCityButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Добавить город", for: .normal)
        but.setTitleColor(.white, for: .normal)
        but.backgroundColor = UIColor(named: "addCityBack")
        but.addTarget(self, action: #selector(addCity), for: .touchUpInside)
        return but
    }()
    
    private lazy var locationButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        return but
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCellSearchTableView.self, forCellReuseIdentifier: "Id")
        tableView.separatorStyle = .none
        
        backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        title = "Мои города"
        setNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weatherModelArray = WeatherModelArray.weatherModelArray
        updateTheme()
    }
    
    override func viewWillLayoutSubviews() {
        tableView.rowHeight = tableView.bounds.height / 11.11
        
        popUpView.size = CGRect(x: 0, y: 0, width: view.bounds.width / 1.09, height: view.bounds.height / 3.7)
        popUpView.setConstraints()
        popUpView.layer.cornerRadius = popUpView.bounds.height / 7.5
        popUpView.clipsToBounds = true
        
        popUpView.textField.layer.cornerRadius = popUpView.textField.bounds.height / 3.33
        popUpView.textField.clipsToBounds = true
        popUpView.textField.layer.borderWidth = 1
        popUpView.textField.layer.borderColor = Theme.currentTheme.borderTextField?.cgColor
        
        popUpView.cancelButton.layer.cornerRadius = popUpView.cancelButton.bounds.height / 3.33
        popUpView.cancelButton.clipsToBounds = true
        
        popUpView.addButton.layer.cornerRadius = popUpView.addButton.bounds.height / 3.33
        popUpView.addButton.clipsToBounds = true
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        view.bounds.height / 83.375
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return weatherModelArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Id", for: indexPath) as? CustomCellSearchTableView else {return UITableViewCell()}
        cell.selectionStyle = .none
        if popUpView.isHidden {
            cell.backgroundColor = Theme.currentTheme.cellBackground
            cell.isUserInteractionEnabled = true
            cell.shadow.isHidden = true
            tableView.isScrollEnabled = true
        }
        else {
            cell.backgroundColor = UIColor(named: "tableViewBackPopUpView")
            cell.isUserInteractionEnabled = false
            cell.shadow.isHidden = false
            tableView.isScrollEnabled = false
        }
        
        cell.cityNameLabel.text = weatherModelArray[indexPath.section].city.name
        cell.firstTemperatureLabel.text = String(Int(weatherModelArray[indexPath.section].list[0].main.temp))
        cell.secondTemperatureLabel.text = String(Int(weatherModelArray[indexPath.section].list[0].main.temp_max))
        cell.weatherImageView.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(weatherModelArray[indexPath.section].list[0].weather[0].icon)@2x.png")
        
        cell.layer.cornerRadius = cell.bounds.height / 4.6
        cell.clipsToBounds = true
        cell.setFonts(view: tableView)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weatherViewController?.modelWeather = weatherModelArray[indexPath.section]
        navigationController?.popViewController(animated: true)
    }

    
    
    private func setConstraints() {
        view.addSubview(addCityButton)
        view.addSubview(locationButton)
        view.addSubview(popUpView)
        
        NSLayoutConstraint.activate([
            addCityButton.leftAnchor.constraint(equalTo: tableView.leftAnchor, constant: tableView.bounds.width / 5),
            addCityButton.heightAnchor.constraint(equalToConstant: view.bounds.height / 16.45),
            addCityButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 2.48),
            addCityButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            locationButton.heightAnchor.constraint(equalTo: addCityButton.heightAnchor),
            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor),
            locationButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -(view.bounds.width / 5)),
            locationButton.centerYAnchor.constraint(equalTo: addCityButton.centerYAnchor),
            
            popUpView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 4.76),
            popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3.7),
            popUpView.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.09),
            
        ])
    }
    
    private func setNavigationItem() {
        self.navigationItem.rightBarButtonItem = changeThemeButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
    }
    
    private func updateTheme() {
        tableView.reloadData()
        
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.background
        
        changeThemeButton.tintColor = Theme.currentTheme.navigationItemTint
        
        backButton.backgroundColor = Theme.currentTheme.navigationItemBack
        backButton.tintColor = Theme.currentTheme.navigationItemTint
        
        locationButton.backgroundColor = Theme.currentTheme.navigationItemBack
        locationButton.tintColor = Theme.currentTheme.navigationItemTint
        
        popUpView.backgroundColor = Theme.currentTheme.popUpBack
        popUpView.cancelButton.backgroundColor = Theme.currentTheme.cancelButtonPopUP
        popUpView.cancelButton.setTitleColor(Theme.currentTheme.cancelButtonTitle, for: .normal)
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.text ?? .black]
        view.backgroundColor = Theme.currentTheme.background
    }
    
    override func viewDidLayoutSubviews() {
        setConstraints()
        
        addCityButton.layer.cornerRadius = addCityButton.bounds.height / 3.3
        addCityButton.clipsToBounds = true
        addCityButton.titleLabel?.font = .systemFont(ofSize: addCityButton.bounds.height / 2.8)
        
        locationButton.layer.cornerRadius = locationButton.bounds.height / 3.3
        locationButton.clipsToBounds = true
        
        backButton.layer.cornerRadius = backButton.bounds.height / 4
        backButton.clipsToBounds = true
        
        
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor).isActive = true
    }
    
    internal func returnDefaultStyle() {
        popUpView.isHidden = true
        popUpView.endEditing(true)
        popUpView.textField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.isUserInteractionEnabled = true
        tableView.reloadData()
        tableView.backgroundColor = Theme.currentTheme.background
    }

    
    @objc func addCity() {
        
        popUpView.isHidden = false
        popUpView.textField.backgroundColor = Theme.currentTheme.textFieldBack 
        popUpView.cancelButton.backgroundColor = Theme.currentTheme.cellBackground
        popUpView.addButton.backgroundColor = UIColor(named: "addCityBack")
        tableView.reloadData()
        tableView.backgroundColor = UIColor(named: "tableViewBackPopUpView")
        popUpView.isUserInteractionEnabled = true
        popUpView.textField.isUserInteractionEnabled = true
        popUpView.textField.becomeFirstResponder()
        popUpView.textField.delegate = self
        
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        popUpView.cancelButton.addTarget(self, action: #selector(closePopUpView), for: .touchUpInside)
        popUpView.addButton.addTarget(self, action: #selector(addNewCity), for: .touchUpInside)
        
    }
    
    @objc func closePopUpView() {
        returnDefaultStyle()
    }
    
    @objc func addNewCity() {
        guard let city = popUpView.textField.text else {
            print("city text field error")
            return
        }
        presenter?.loadDataCurrentCity(city: city)
        returnDefaultStyle()
    }
    
    @objc func changeTheme() {
        Theme.changeTheme()
        updateTheme()
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

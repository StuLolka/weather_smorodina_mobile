//
//  TableViews.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 30.08.2021.
//

import UIKit

final class TableViews: UITableView {
    var searchDelegate: SearchTableViewController?
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.compact.left"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentVerticalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 9.58, left: 12.33, bottom: 9.58, right: 12.33)
        return button
    }()
    
    private lazy var changeThemeButton: UIButton = {
        let changeThemeButton = UIButton()
        changeThemeButton.setImage(UIImage(systemName: "sun.min"), for: .normal)
        return changeThemeButton
    }()
    
    private lazy var addCityButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Добавить город", for: .normal)
        but.setTitleColor(.white, for: .normal)
        but.backgroundColor = UIColor(named: "addCityBack")
        return but
    }()
    
    lazy var popUpView: PopUpView = {
        let view = PopUpView()
        view.searchDelegate = searchDelegate
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.currentTheme.textFieldBack
        return view
    }()
    
    lazy var locationButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        return but
    }()
    
    func addBackButtonAction(_ popViewController: @escaping(() -> ())) {
        backButton.addAction {
            popViewController()
        }
    }
    
    func addCityAction(_ addCity: @escaping(() -> ())) {
        addCityButton.addAction {
            addCity()
        }
    }
    
    func addChangeThemeAction(_ changeTheme: @escaping(() -> ())) {
        changeThemeButton.addAction {
            changeTheme()
        }
    }
    
    func addUserLocationAction(_ getUserLocation: @escaping(() -> ())) {
        locationButton.addAction {
            getUserLocation()
        }
    }
    
    func setViews(navigationItem: UINavigationItem) {
        
        popUpView.size = CGRect(x: 0, y: 0, width: bounds.width / 1.09, height: bounds.height / 3.7)
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
        
        addCityButton.layer.cornerRadius = addCityButton.bounds.height / 3.3
        addCityButton.clipsToBounds = true
        addCityButton.titleLabel?.font = .systemFont(ofSize: addCityButton.bounds.height / 2.8)
        
        locationButton.layer.cornerRadius = locationButton.bounds.height / 3.3
        locationButton.clipsToBounds = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: changeThemeButton)
        changeThemeButton.frame = CGRect(x: 0, y: 0, width: bounds.width / 11.71, height: bounds.width / 11.71)
        changeThemeButton.layer.cornerRadius = bounds.width / 46.875
        changeThemeButton.clipsToBounds = true
    }
    
    func createBackButton(navigationItem: UINavigationItem) {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: bounds.width / 11.71),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor),
        ])
        
        backButton.layer.cornerRadius = bounds.width / 46.875
        backButton.clipsToBounds = true
    }

    
    func setConstraints() {
        addSubview(activityIndicator)
        addSubview(addCityButton)
        addSubview(locationButton)
        addSubview(popUpView)
        
        NSLayoutConstraint.activate([
            
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            addCityButton.leftAnchor.constraint(equalTo: leftAnchor, constant: bounds.width / 5),
            addCityButton.heightAnchor.constraint(equalToConstant: bounds.height / 16.45),
            addCityButton.widthAnchor.constraint(equalToConstant: bounds.width / 2.48),
            addCityButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            locationButton.heightAnchor.constraint(equalTo: addCityButton.heightAnchor),
            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor),
            locationButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -(bounds.width / 5)),
            locationButton.centerYAnchor.constraint(equalTo: addCityButton.centerYAnchor),
            
            popUpView.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 4.76),
            popUpView.centerXAnchor.constraint(equalTo: centerXAnchor),
            popUpView.heightAnchor.constraint(equalToConstant: bounds.height / 3.7),
            popUpView.widthAnchor.constraint(equalToConstant: bounds.width / 1.09),
            
        ])
    }
    
    func updateTheme() {
        changeThemeButton.backgroundColor = Theme.currentTheme.navigationItemBack
        changeThemeButton.tintColor = Theme.currentTheme.navigationItemTint
        
        backButton.backgroundColor = Theme.currentTheme.navigationItemBack
        backButton.tintColor = Theme.currentTheme.navigationItemTint
        
        popUpView.updateTheme()
        
    }
}

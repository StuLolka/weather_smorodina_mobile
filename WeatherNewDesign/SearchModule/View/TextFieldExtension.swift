//
//  TextFieldExtension.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 20.08.2021.
//

import UIKit

extension SearchTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        tableViews.popUpView.isHidden = true
        returnDefaultStyle()
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return }
        if text.count >= 3 {
            var i = 0
            while i < ListMajorCities.citiesArray.count {
                guard let element = ArrayExtension.getElementFromArray(i, &ListMajorCities.citiesArray) else {return }
                
                if element.city.contains(text) {
                    if !isSameCity(element.city) {
                        HintCityList.cityArray.append(element.city)
                        reloadDataCollection()
                    }
                }
                
                if HintCityList.cityArray.count > 0 {
                    var i = 0
                    while i < HintCityList.cityArray.count {
                        if !HintCityList.cityArray[i].contains(text) {
                            HintCityList.cityArray.remove(at: i)
                            reloadDataCollection()
                        }
                        i += 1
                    }
                }
                i += 1
            }
        }
        else {
            removeHintCities()
        }
    }
    
    private func removeHintCities() {
        HintCityList.cityArray = []
        reloadDataCollection()
    }
    
    private func isSameCity(_ city: String) -> Bool {
        var i = 0
        while i < HintCityList.cityArray.count {
            if HintCityList.cityArray[i] == city {
                return true
            }
            i += 1
        }
        return false
    }
}

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
        popUpView.isHidden = true
        returnDefaultStyle()
        return false
    }
}

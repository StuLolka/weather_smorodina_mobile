//
//  PopUpViewExtensionCollectionView.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 09.09.2021.
//

import UIKit

extension PopUpView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HintCityList.cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintCitiesCell.idCell, for: indexPath) as? HintCitiesCell else {
            print("cell error")
            return UICollectionViewCell()}
        cell.backgroundColor = Theme.currentTheme.collectionCellBack
        cell.layer.cornerRadius = cell.bounds.width / 5
        cell.cityLabel.text = HintCityList.cityArray[indexPath.row]
        updateTheme()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let city = ArrayExtension.getElementFromArray(indexPath.row, &HintCityList.cityArray) else {return }
        textField.text = city
        HintCityList.cityArray = []
        guard let search = searchDelegate else {
            print("wtf")
            return
        }
        search.addNewCity()
    }

}

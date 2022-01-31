//
//  PopUpView.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 19.08.2021.
//

import UIKit

final class PopUpView: UIView {
    
    var size: CGRect = CGRect(x: 0, y: 0, width: 343, height: 180)
    var searchDelegate: SearchTableViewController?
    
    lazy var miniView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var textField: UISearchTextField = {
        let field = UISearchTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var cityHintCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HintCitiesCell.self, forCellWithReuseIdentifier: HintCitiesCell.idCell)
        collection.alwaysBounceHorizontal = true
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    lazy var cancelButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Cancel", for: .normal)
        return but
    }()
    
    lazy var addButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Add", for: .normal)
        but.setTitleColor(.white, for: .normal)
        return but
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints() {
        addSubview(textField)
        addSubview(cityHintCollectionView)
        addSubview(cancelButton)
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: topAnchor, constant: size.height / 11.25),
            textField.heightAnchor.constraint(equalToConstant: size.height / 4.5),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: size.width / 21.43),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -(size.width / 21.43)),
            
            cityHintCollectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12),
            cityHintCollectionView.leftAnchor.constraint(equalTo: textField.leftAnchor, constant: 12),
            cityHintCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            cityHintCollectionView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -12),
            
            cancelButton.leftAnchor.constraint(equalTo: leftAnchor, constant: size.width / 21.43),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(size.width / 21.43)),
            cancelButton.widthAnchor.constraint(equalToConstant: size.width / 2.27),
            cancelButton.heightAnchor.constraint(equalToConstant: size.height / 4.5),

            addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -(size.width / 21.43)),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(size.width / 21.43)),
            addButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),
            addButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)
        ])
    }
    
    func updateTheme() {
        backgroundColor = Theme.currentTheme.popUpBack
        cancelButton.backgroundColor = Theme.currentTheme.cancelButtonPopUP
        cancelButton.setTitleColor(Theme.currentTheme.cancelButtonTitle, for: .normal)
        cityHintCollectionView.backgroundColor = backgroundColor
    }
}

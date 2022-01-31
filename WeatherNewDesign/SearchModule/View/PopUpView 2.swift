//
//  PopUpView.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 19.08.2021.
//

import UIKit

final class PopUpView: UIView {
    
    internal var size: CGRect = CGRect(x: 0, y: 0, width: 343, height: 180)
    
    internal lazy var miniView: UIView = {
        let view = UIView()
        
        return view
    }()
    internal lazy var textField: UISearchTextField = {
        let field = UISearchTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    internal lazy var cancelButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Cancel", for: .normal)
        return but
    }()
    
    internal lazy var addButton: UIButton = {
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
    
    
    internal func setConstraints() {
        addSubview(textField)
        addSubview(cancelButton)
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: topAnchor, constant: size.height / 11.25),
            textField.heightAnchor.constraint(equalToConstant: size.height / 4.5),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: size.width / 21.43),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -(size.width / 21.43)),
            
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
}

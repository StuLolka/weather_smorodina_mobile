//
//  Closure.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 07.09.2021.
//

import UIKit

class ClosureSleeve {
    let closure: () -> ()

    init(attachTo: AnyObject, closure: @escaping () -> ()) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }

    @objc func invoke() {
        closure()
    }
}


extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, action: @escaping () -> ()) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
}

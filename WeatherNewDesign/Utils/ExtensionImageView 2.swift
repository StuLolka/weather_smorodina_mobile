//
//  ExtensionImageView.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 18.08.2021.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadImageFromURL(url: String) {
        self.image = nil
        guard let URL = URL(string: url) else {
            print("No Image For this url", url)
            return
        }

        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL) {
                if let image = UIImage(data: data) {
                    let imageTocache = image
                    imageCache.setObject(imageTocache, forKey: url as AnyObject)

                    DispatchQueue.main.async {
                        self?.image = imageTocache
                    }
                }
            }
        }

    }
}

//
//  SceneDelegate.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit
import NeedleFoundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        registerProviderFactories()
        let router = Router.shared
        
        window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = router.openMainScreen()
        self.window?.makeKeyAndVisible()
    }
}


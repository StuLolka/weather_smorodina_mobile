

import CoreLocation
import Foundation
import MapKit
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->MyRootComponent->CityPresenterComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->MyRootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->MyRootComponent->SearchPresenterComponent") { component in
        return SearchPresenterDependency84498c5dc0864e62486aProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->MyRootComponent->WeatherPresenterComponent") { component in
        return WeatherPresenterDependency96f1592d5574ae17e1c4Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->MyRootComponent->MapPresenterComponent") { component in
        return MapPresenterDependency582030f357b54415e22fProvider(component: component)
    }
    
}

// MARK: - Providers

private class SearchPresenterDependency84498c5dc0864e62486aBaseProvider: SearchPresenterDependency {
    var network: NetworkProtocol {
        return myRootComponent.network
    }
    private let myRootComponent: MyRootComponent
    init(myRootComponent: MyRootComponent) {
        self.myRootComponent = myRootComponent
    }
}
/// ^->MyRootComponent->SearchPresenterComponent
private class SearchPresenterDependency84498c5dc0864e62486aProvider: SearchPresenterDependency84498c5dc0864e62486aBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(myRootComponent: component.parent as! MyRootComponent)
    }
}
private class WeatherPresenterDependency96f1592d5574ae17e1c4BaseProvider: WeatherPresenterDependency {
    var network: NetworkProtocol {
        return myRootComponent.network
    }
    var location: LocationFacadeProtocol {
        return myRootComponent.location
    }
    private let myRootComponent: MyRootComponent
    init(myRootComponent: MyRootComponent) {
        self.myRootComponent = myRootComponent
    }
}
/// ^->MyRootComponent->WeatherPresenterComponent
private class WeatherPresenterDependency96f1592d5574ae17e1c4Provider: WeatherPresenterDependency96f1592d5574ae17e1c4BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(myRootComponent: component.parent as! MyRootComponent)
    }
}
private class MapPresenterDependency582030f357b54415e22fBaseProvider: MapPresenterDependency {
    var network: NetworkProtocol {
        return myRootComponent.network
    }
    private let myRootComponent: MyRootComponent
    init(myRootComponent: MyRootComponent) {
        self.myRootComponent = myRootComponent
    }
}
/// ^->MyRootComponent->MapPresenterComponent
private class MapPresenterDependency582030f357b54415e22fProvider: MapPresenterDependency582030f357b54415e22fBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(myRootComponent: component.parent as! MyRootComponent)
    }
}

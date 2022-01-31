//
//  ArrayTest.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 06.09.2021.
//

import Foundation

final class ArrayExtension {
    static func getElementFromArray<T>(_ index: Int, _ array: inout [T]) -> T? {
        guard index < array.count else {return nil}
        return array[index]
    }
}

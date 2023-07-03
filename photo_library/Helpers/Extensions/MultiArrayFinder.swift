//
//  MultiArrayFinder.swift
//  photo_library
//
//  Created by Артур Кулик on 03.07.2023.
//

import Foundation

/// Расширение для поиска элемента многомерного массива с массивом в качестве параметра
extension Array where Element : MutableCollection, Index == Element.Index{
    subscript(_ indeces: [Int]) -> Element.Element {
        get { return self[indeces[0]][indeces[1]] }
        set { return self[indeces[0]][indeces[1]] = newValue }
    }
}

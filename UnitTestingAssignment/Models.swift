//
//  Models.swift
//  UnitTestingAssignment
//
//  Created by Baramidze on 02.12.23.
//

import Foundation

struct ProductList: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    var id: Int?
    var title: String?
    var description: String?
    var price: Double?
    var selectedQuantity: Int? = 0
}



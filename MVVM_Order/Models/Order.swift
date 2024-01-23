//
//  Ordel.swift
//  MVVM_Order
//
//  Created by Chung Wussup on 1/23/24.
//

import Foundation

enum CoffeeType: String, Codable {
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeeSize: String, Codable {
    case small
    case medium
    case large
}

struct Order : Codable {
    
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeType
    
}

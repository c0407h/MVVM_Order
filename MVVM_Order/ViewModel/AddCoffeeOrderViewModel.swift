//
//  AddCoffeeOrderViewModel.swift
//  MVVM_Order
//
//  Created by Chung Wussup on 1/23/24.
//

import Foundation


struct AddCoffeeOrderViewModel {

    var name: String?
    var email: String?
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
    
}

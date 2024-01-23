//
//  OrderViewModel.swift
//  MVVM_Order
//
//  Created by Chung Wussup on 1/23/24.
//
//주문데이터 받은후 데이터 view에 표시

import Foundation

struct OrderListViewModel {
    var ordersViewModel: [OrderViewModel]

    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
    
}

struct OrderViewModel {
    let order: Order
    
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
}

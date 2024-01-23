//
//  OrdersTVController.swift
//  MVVM_Order
//
//  Created by Chung Wussup on 1/23/24.
//

import UIKit

class OrdersTVController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        populateOrders()
        
    }
    
    private func populateOrders() {
        guard let coffeeOrdersURL = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL was incorrect")
        }
        
        let resource = Resource<[Order]>(url: coffeeOrdersURL)
        
        OrderService().load(resource: resource) { result in
            switch result {
            case .success(let orders):
                print(orders)
            case .failure(let error):
                print(error)
            }
        }
    }
}



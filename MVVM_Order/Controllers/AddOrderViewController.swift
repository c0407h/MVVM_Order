//
//  AddOrderViewController.swift
//  MVVM_Order
//
//  Created by Chung Wussup on 1/23/24.
//


import UIKit

protocol AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController)
}

class AddOrderViewController: UIViewController {
    
    var delegate: AddCoffeeOrderDelegate?
    
    private var vm = AddCoffeeOrderViewModel()
    @IBOutlet weak var tableView: UITableView!
    private var coffeeSizeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var nameUITextField: UITextField!
    @IBOutlet weak var emailUITextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
    }
    
    private func setupUI() {
        self.coffeeSizeSegmentedControl = UISegmentedControl(items: self.vm.sizes)
        self.coffeeSizeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.coffeeSizeSegmentedControl)
        self.coffeeSizeSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        self.coffeeSizeSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    
    @IBAction func save(_ sender: Any) {
        let name = self.nameUITextField.text
        let email = self.emailUITextField.text
        
        let selectSize = self.coffeeSizeSegmentedControl.titleForSegment(at: self.coffeeSizeSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("error in selecting coffee")
        }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = selectSize
        self.vm.selectedType = self.vm.types[indexPath.row]
        
        
        OrderService().load(resource: Order.create(vm: self.vm)) { result in
            switch result {
            case .success(let order):
                
                if let order = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    @IBAction func close(_ sender: Any) {
        
        if let delegate = self.delegate {
            delegate.addCoffeeOrderViewControllerDidClose(controller: self)
        }
        
    }
    
}

extension AddOrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTVCell", for: indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
    }
    
    
}

extension AddOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //셀 체크마크 추가
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

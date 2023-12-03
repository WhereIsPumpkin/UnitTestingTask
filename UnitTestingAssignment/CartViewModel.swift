//
//  CartViewModel.swift
//  UnitTestingAssignment
//
//  Created by Baramidze on 02.12.23.
//

import Foundation

final class CartViewModel {
    
    var allproducts: [Product]?
    
    var selectedProducts = [Product]()
    
    var selectedItemsQuantity: Int? {
        selectedProducts.reduce(0) { $0 + ($1.selectedQuantity ?? 0) }
    }
    
    var totalPrice: Double? {
        selectedProducts.reduce(0.0) { $0 + Double($1.selectedQuantity ?? 0) * ($1.price ?? 0)  }
    }
    
    func viewDidLoad() {
        fetchProducts {
            print(self.allproducts ?? "No Products")
        }
    }
    
    func fetchProducts(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchProducts { [weak self] products in
            switch products {
            case .success(let products):
                self?.allproducts = products
                completion()
            case .failure(_):
                print("Cannot fetch")
                break
            }
        }
    }

    
    func addProduct(withID: Int?) {
        if let productForAdd = allproducts?.first(where: { $0.id == withID }) {
            addProduct(product: productForAdd)
        }
    }
    
    func addProduct(product: Product?) {
        guard let product else { return }
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            selectedProducts[index].selectedQuantity! += product.selectedQuantity!
        } else {
            selectedProducts.append(product)
        }
    }
    
    func addRandomProduct() {
        addProduct(product: allproducts?.randomElement())
    }
    
    func removeProduct(withID: Int) {
        selectedProducts.removeAll(where: { $0.id == withID })
    }
    
    func clearCart() {
        selectedProducts.removeAll()
    }
}

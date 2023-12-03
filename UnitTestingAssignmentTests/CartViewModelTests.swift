//
//  CartViewmodelTests.swift
//  UnitTestingAssignmentTests
//
//  Created by Saba Gogrichiani on 03.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class CartViewModelTests: XCTestCase {
    
    var cartViewModel: CartViewModel!
    
    override func setUp() {
        super.setUp()
        cartViewModel = CartViewModel()
    }
    
    override func tearDown() {
        cartViewModel = nil
        super.tearDown()
    }
    
    func testFetchProducts() {
         // Test if products are fetched correctly
         let expectation = XCTestExpectation(description: "Fetch products")
         cartViewModel.fetchProducts {
             XCTAssertNotNil(self.cartViewModel.allproducts)
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 10.0)
     }
    
    func testAddProductWithID() {
        // Test if a product is added correctly with ID
        let expectation = XCTestExpectation(description: "Fetch products and add product with ID")
        cartViewModel.fetchProducts {
            let initialCount = self.cartViewModel.selectedProducts.count
            self.cartViewModel.addProduct(withID: 1)
            XCTAssertEqual(self.cartViewModel.selectedProducts.count, initialCount + 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    
    func testAddProduct() {
        // Test if a product is added correctly
        let initialCount = cartViewModel.selectedProducts.count
        let product = Product(id: 1, title: "Test", description: "Test Product", price: 10.0, selectedQuantity: 1)
        cartViewModel.addProduct(product: product)
        XCTAssertEqual(cartViewModel.selectedProducts.count, initialCount + 1)
    }
    
    func testAddRandomProduct() {
        // Test if a random product is added correctly
        let expectation = XCTestExpectation(description: "Fetch products and add random product")
        cartViewModel.fetchProducts {
            let initialCount = self.cartViewModel.selectedProducts.count
            self.cartViewModel.addRandomProduct()
            XCTAssertEqual(self.cartViewModel.selectedProducts.count, initialCount + 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    
    func testRemoveProduct() {
        // Test if a product is removed correctly
        let product = Product(id: 1, title: "Test", description: "Test Product", price: 10.0, selectedQuantity: 1)
        cartViewModel.addProduct(product: product)
        let initialCount = cartViewModel.selectedProducts.count
        cartViewModel.removeProduct(withID: 1)
        XCTAssertEqual(cartViewModel.selectedProducts.count, initialCount - 1)
    }
    
    func testClearCart() {
        // Test if the cart is cleared correctly
        let product = Product(id: 1, title: "Test", description: "Test Product", price: 10.0, selectedQuantity: 1)
        cartViewModel.addProduct(product: product)
        cartViewModel.clearCart()
        XCTAssertEqual(cartViewModel.selectedProducts.count, 0)
    }
    
    func testTotalPrice() {
        // Test if the total price is calculated correctly
        let product = Product(id: 1, title: "Test", description: "Test Product", price: 10.0, selectedQuantity: 1)
        cartViewModel.addProduct(product: product)
        XCTAssertEqual(cartViewModel.totalPrice, 10.0)
    }
    
    func testSelectedItemsQuantity() {
        // Test if the quantity of selected items is calculated correctly
        let product = Product(id: 1, title: "Test", description: "Test Product", price: 10.0, selectedQuantity: 1)
        cartViewModel.addProduct(product: product)
        XCTAssertEqual(cartViewModel.selectedItemsQuantity, 1)
    }
}


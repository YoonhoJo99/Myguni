//
//  CartDetailViewController.swift
//  Myguni
//
//  Created by 조윤호 on 6/15/24.
//

import UIKit

final class CartDetailViewController: UIViewController {
    
    private let cart: Cart
    private let cartDetailView = CartDetailView()
    
    init(cart: Cart) {
        self.cart = cart
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = cartDetailView
        
        cartDetailView.nameTextField.text = cart.title
        cartDetailView.tableView.dataSource = self
        cartDetailView.tableView.delegate = self
        cartDetailView.tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    func setupAddTarget() {
        // 필요한 경우 버튼 액션 설정 가능
    }
}

// MARK: - UITableViewDataSource

extension CartDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
        let item = cart.items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CartDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected item: \(cart.items[indexPath.row])")
        // 선택된 항목에 대한 추가적인 작업 구현 가능
    }
}


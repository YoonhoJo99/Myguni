//
//  CartDetailViewController.swift
//  Myguni
//
//  Created by 조윤호 on 6/15/24.
//

import UIKit
import RealmSwift

final class CartDetailViewController: UIViewController {
    
    private let cart: Cart
    
    private let cartDetailView = CartDetailView()
    
    private let cartDetailManager = CartDetailManager()
    
    init(cart: Cart) {
        self.cart = cart
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = cartDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartDetailView.nameTextField.text = cart.title
        
        cartDetailView.tableView.dataSource = self
        cartDetailView.tableView.delegate = self
        cartDetailView.tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
        
        setupAddTarget()
    }
    
    func setupAddTarget() {
        cartDetailView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        cartDetailView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        cartDetailView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        print("장바구니 목록 추가하기 버튼 호출")
        
        let newItem = CartItem(name: "", count: 1)
        
        do {
            let realm = try Realm()
            try realm.write {
                cart.items.append(newItem)
            }
            
            let indexPath = IndexPath(row: cart.items.count - 1, section: 0)
            cartDetailView.tableView.insertRows(at: [indexPath], with: .fade)
        } catch {
            print("Failed to add item: \(error.localizedDescription)")
        }
    }

    @objc func editButtonTapped() {
        print("돌아가기 버튼 호출")
        
        // 메인 뷰로 화면 이동
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func deleteButtonTapped() {
        print("삭제 버튼 호출")
        
        // 선택한 Cart 객체의 title 가져오기
        let cartTitleToDelete = cart.title
        cartDetailManager.deleteCartWithTitle(cartTitleToDelete)
        
        // 메인 뷰로 화면 이동
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
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
        cell.delegate = self // Cell에 delegate 설정
        return cell
    }
}

// MARK: - CartItemCellDelegate

extension CartDetailViewController: CartItemCellDelegate {
    
    func cartItemCellDidTapDelete(_ cell: CartItemCell) {
        guard let indexPath = cartDetailView.tableView.indexPath(for: cell) else { return }
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(cart.items[indexPath.row]) // Realm에서 해당 아이템 삭제
            }
            
            cartDetailView.tableView.deleteRows(at: [indexPath], with: .automatic) // TableView에서 셀 삭제
        } catch {
            print("Failed to delete item: \(error.localizedDescription)")
        }
    }
    
    func cartItemCellDidUpdateName(_ cell: CartItemCell, didUpdateName name: String?) {
        guard let indexPath = cartDetailView.tableView.indexPath(for: cell) else { return }
        
        do {
            let realm = try Realm()
            try realm.write {
                cart.items[indexPath.row].name = name ?? "" // Realm에서 이름 업데이트
            }
        } catch {
            print("Failed to update item name: \(error.localizedDescription)")
        }
    }
    
    func cartItemCellDidUpdateCount(_ cell: CartItemCell, didUpdateCount count: Int) {
        guard let indexPath = cartDetailView.tableView.indexPath(for: cell) else { return }
        
        do {
            let realm = try Realm()
            try realm.write {
                cart.items[indexPath.row].count = count // Realm에서 수량 업데이트
            }
        } catch {
            print("Failed to update item count: \(error.localizedDescription)")
        }
    }
}

// MARK: - UITableViewDelegate

extension CartDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected item: \(cart.items[indexPath.row])")
        // 선택된 항목에 대한 추가적인 작업 구현 가능
    }
}



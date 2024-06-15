//
//  NewCartViewController.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import UIKit
import RealmSwift

final class NewCartViewController: UIViewController {

    private let newCartView = NewCartView()
    
    private let newCartManager = NewCartManager()
    
    private var cartItems = List<CartItem>()
    
    override func loadView() {
        view = newCartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddTarget()
        
        newCartView.tableView.dataSource = self
        newCartView.tableView.delegate = self
        newCartView.tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
    }
    
    func setupAddTarget() {
        newCartView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        newCartView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc func addButtonTapped() {
        print("장바구니 목록 추가하기 버튼 호출")
        
        // 새 항목 추가
        let newItem = CartItem(name: "", count: 1)
        cartItems.append(newItem)
        
        // 새로운 셀을 테이블 뷰에 삽입하고 애니메이션 적용
        let indexPath = IndexPath(row: cartItems.count - 1, section: 0)
        newCartView.tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    @objc func saveButtonTapped() {
        print("저장하기 버튼 호출")
        
        // 새로운 카트 저장 -> 동일한 이름의 카트 입력시 경고 발생. 저장 불가능
        newCartManager.saveData(newCartView.nameTextField.text, cartItems) { [weak self] success in
            guard let self = self else { return }
            
            if success {
                // 저장 성공, 메인 뷰 컨트롤러로 이동
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                // 저장 실패 (중복된 이름)
                print("동일한 이름의 카트가 이미 존재합니다.")
                DispatchQueue.main.async {
                    self.showAlert(title: "중복된 이름", message: "동일한 이름의 카트가 이미 존재합니다.")
                }
            }
        }
    }


    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

//
extension NewCartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
        cell.delegate = self
        return cell
    }
}

//
extension NewCartViewController: CartItemCellDelegate {
    
    func cartItemCellDidTapDelete(_ cell: CartItemCell) {
        if let indexPath = newCartView.tableView.indexPath(for: cell) {
            cartItems.remove(at: indexPath.row)
            newCartView.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func cartItemCellDidUpdateName(_ cell: CartItemCell, didUpdateName name: String?) {
        if let indexPath = newCartView.tableView.indexPath(for: cell) {
            cartItems[indexPath.row].name = name ?? ""
        }
    }
    
    func cartItemCellDidUpdateCount(_ cell: CartItemCell, didUpdateCount count: Int) {
        if let indexPath = newCartView.tableView.indexPath(for: cell) {
            cartItems[indexPath.row].count = count
        }
    }
}

// MARK: - UITableViewDelegate

extension NewCartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row + 1)")
    }
}



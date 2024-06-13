//
//  NewCartViewController.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import UIKit

final class NewCartViewController: UIViewController {

    private let newCartView = NewCartView()
    
//    private let defaultManager = defaultManager()
    
    override func loadView() { // -> viewDidLoad()보다 먼저 호출이 되는 메소드 -> 기본 view를 교체해줄 수 있음
        view = newCartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddTarget()
        
        newCartView.tableView.dataSource = self
        newCartView.tableView.delegate = self
        newCartView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CartItemCell")
    }
    
    func setupAddTarget() {
        newCartView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        newCartView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc func addButtonTapped() {
        print("addButton 호출")
        // 테이블 뷰에 셀을 하나씩 추가.
    }
    
    @objc func saveButtonTapped() {
        print("saveButton 호출")
    }
}

extension NewCartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10 // 예시로 10개의 셀을 만듭니다.
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
//        cell.textLabel?.text = "Row \(indexPath.row + 1)"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewCartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Selected row: \(indexPath.row + 1)")
    }
}

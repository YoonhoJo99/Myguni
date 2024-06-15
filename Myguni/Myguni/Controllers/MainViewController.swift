//
//  MainViewController.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import UIKit
import RealmSwift

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private let mainManager = MainManager()
    private var carts: Results<Cart>?
    private var notificationToken: NotificationToken?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddTarget()
        
        additionalSafeAreaInsets.top = -49 // 기본 탭바 높이 만큼 safeArea영역 증가. Tabbar의 rootViewController는...
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
        
        // Realm에서 저장된 Cart 데이터 가져오기
        loadCarts()
        
        // Realm 데이터 변경을 감지하여 테이블 뷰를 업데이트
        observeRealmChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 화면이 나타날 때마다 데이터를 다시 로드하여 테이블 뷰를 업데이트
        loadCarts()
    }
    
    private func setupAddTarget() {
        mainView.floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingButtonTapped() {
        print("플로팅 버튼 클릭")
        let newCartVC = NewCartViewController()
        navigationController?.pushViewController(newCartVC, animated: true)
    }
    
    private func loadCarts() {
        carts = mainManager.getAllCarts()
//        print(carts)
        mainView.tableView.reloadData()
    }
    
    private func observeRealmChanges() {
        guard let realm = mainManager.realmInstance else {
            return
        }
        
        // Realm의 알림 기능을 이용하여 데이터 변경 감지
        notificationToken = realm.observe { [weak self] _, _ in
            // 데이터 변경 시 테이블 뷰를 업데이트
            self?.loadCarts()
        }
    }
    
    deinit {
        // 알림 토큰 해제
        notificationToken?.invalidate()
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        if let cart = carts?[indexPath.row] {
            cell.nameLabel.text = cart.title
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCart = carts?[indexPath.row] else {
            return
        }
        
        print("Selected row: \(indexPath.row)")
        print(selectedCart.title, selectedCart.items)
        
        // 선택한 카트 정보를 담은 뷰 컨트롤러 생성
        let cartDetailVC = CartDetailViewController(cart: selectedCart)
        navigationController?.pushViewController(cartDetailVC, animated: true)
    }
}

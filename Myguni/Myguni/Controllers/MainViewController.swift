//
//  MainViewController.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddTarget()
        
        additionalSafeAreaInsets.top = -49 // 기본 탭바 높이 만큼 safeArea영역 증가. Tabbar의 rootViewController는...
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func setupAddTarget() {
        mainView.floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    //
    @objc func floatingButtonTapped() {
        print("플로팅 버튼 클릭")
        let newCartVC = NewCartViewController()
//        newCartVC.modalPresentationStyle = .fullScreen
        present(newCartVC, animated: true, completion: nil)
    }
    
}



// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // 예시로 10개의 셀을 만듭니다.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row + 1)"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row + 1)")
    }
}




//
//  MainView.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import UIKit
import SnapKit
import Then

final class MainView: UIView {
    
    // 제목 라벨
    private let nameLabel = UILabel().then {
        $0.text = "Myguni" // 제목 미정..
        $0.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) // 색깔 변경 예정
        $0.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        $0.textAlignment = .center
    }
    
    // 테이블 뷰
    lazy var tableView = UITableView().then {
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor.gray.cgColor
        $0.separatorStyle = .none
    }
    
    // 플로팅 버튼
    lazy var floatingButton = UIButton(type: .custom).then {
        $0.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) // 버튼 색상
        $0.setTitle("+", for: .normal) // 버튼 제목
        $0.setTitleColor(.white, for: .normal) // 버튼 제목 색상
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold) // 버튼 제목 폰트
        $0.layer.cornerRadius = 30 // 버튼을 원형으로 만들기 위해 cornerRadius를 반으로 설정
        $0.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
        $0.layer.shadowOpacity = 0.3 // 그림자 불투명도
        $0.layer.shadowOffset = CGSize(width: 2, height: 2) // 그림자 오프셋
        $0.layer.shadowRadius = 3 // 그림자 반경
    }
    
    // 메시지 뷰
    private let messageLabel = UILabel().then {
        $0.text = "우측 하단에 있는 + 버튼을 눌러 카트를 추가해보세요!"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.isHidden = true // 초기에는 숨김
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.backgroundColor = .white
    }
    
    private func addViews() {
        addSubview(nameLabel)
        addSubview(tableView)
        addSubview(floatingButton)
        addSubview(messageLabel) // 메시지 뷰 추가
    }
    
    private func setConstraints() {
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(30)
            $0.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.left.right.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        floatingButton.snp.makeConstraints {
            $0.width.height.equalTo(60) // 버튼 크기
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        messageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    
    func showMessage(_ show: Bool) {
        messageLabel.isHidden = !show
    }
}



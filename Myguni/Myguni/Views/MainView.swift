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
        $0.text = "나의 바구니" // 제목 미정..
        $0.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) // 색깔 변경 예정
        $0.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        $0.textAlignment = .center
    }
    
    // 테이블 뷰
    lazy var tableView = UITableView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
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
    }
}


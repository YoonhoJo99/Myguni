//
//  NewCartView.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import UIKit
import SnapKit
import Then
import TextFieldEffects

final class NewCartView: UIView {
    
    // 장바구니 이름 입력 필드
    lazy var nameTextField = HoshiTextField().then {
        $0.placeholder = "타이틀 입력: 예 - 저녁 장보기"
        $0.placeholderColor = .gray
        $0.borderActiveColor = .gray
        $0.borderInactiveColor = .gray
        $0.placeholderFontScale = 1
    }
    
    // 장바구니 목록 추가 버튼
    lazy var addButton = UIButton().then {
        $0.setTitle("장바구니 목록 추가하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        $0.layer.cornerRadius = 10
    }
    
    // 장바구니 목록 테이블 뷰
    lazy var tableView = UITableView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
    }
    
    // 저장 버튼
    lazy var saveButton = UIButton().then {
        $0.setTitle("저장하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        $0.layer.cornerRadius = 10
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
       addSubview(nameTextField)
       addSubview(addButton)
       addSubview(tableView)
       addSubview(saveButton)
    }
    
    private func setConstraints() {
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(70)
            $0.top.equalTo(safeAreaLayoutGuide).inset(40)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(40)
        }
        
        addButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(40)
            $0.bottom.equalTo(saveButton.snp.top).offset(-20)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(50)
        }
        
    }
    
}


//
//  CartCell.swift
//  Myguni
//
//  Created by 조윤호 on 6/15/24.
//

import UIKit
import Then
import SnapKit

final class CartCell: UITableViewCell {
    
    // view 생성
    lazy var view = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    
    // Cart 이름 라벨
    lazy var nameLabel = UILabel().then {
        $0.text = "" //
        $0.textColor = .white // 색깔 변경 예정
        $0.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        $0.textAlignment = .center
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setupConstraints()
        
        backgroundColor = .clear // 셀의 배경색을 투명으로 설정
        
        // 셀 모양을 둥글게 설정
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(view)
        view.addSubview(nameLabel) // nameLabel을 view에 추가
    }
    
    private func setupConstraints() {
        view.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10) // 상단과 하단 여백 추가
            $0.left.right.equalToSuperview().inset(20) // 좌우 여백 추가
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view) // nameLabel을 view의 중앙에 위치
        }
        
        // view의 높이를 60으로 설정
        view.snp.makeConstraints {
            $0.height.equalTo(80)
        }
    }
}


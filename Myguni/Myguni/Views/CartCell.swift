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
    
    // Cart 이름 라벨
    lazy var nameLabel = UILabel().then {
        $0.text = "" //
        $0.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) // 색깔 변경 예정
        $0.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        $0.textAlignment = .center
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        // 스택뷰에 텍스트 필드를 추가
        addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

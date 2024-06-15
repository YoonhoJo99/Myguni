//
//  CartItemCell.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import UIKit
import Then
import SnapKit

protocol CartItemCellDelegate: AnyObject {
    func cartItemCellDidTapDelete(_ cell: CartItemCell)
    func cartItemCellDidUpdateName(_ cell: CartItemCell, didUpdateName name: String?)
    func cartItemCellDidUpdateCount(_ cell: CartItemCell, didUpdateCount count: Int)
}

final class CartItemCell: UITableViewCell {
    
    weak var delegate: CartItemCellDelegate?
    
    // 이름 입력 필드
    private let nameTextField = UITextField().then {
        $0.placeholder = "이름"
        $0.borderStyle = .roundedRect
    }
    
    // 수량 입력 필드
    private let countTextField = UITextField().then {
        $0.placeholder = "1"
        $0.borderStyle = .roundedRect
    }
    
    // 스택뷰
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
        setupTextFieldActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        // 스택뷰에 텍스트 필드를 추가
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(countTextField)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        // 스택뷰의 제약 조건 설정
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16) // 셀의 경계로부터 여백 설정
        }
        
        // 텍스트 필드 너비 비율 설정
        nameTextField.snp.makeConstraints { make in
            make.width.equalTo(countTextField.snp.width).multipliedBy(2)
        }
    }
    
    private func setupTextFieldActions() {
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged)
        countTextField.addTarget(self, action: #selector(countTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func nameTextFieldDidChange(_ textField: UITextField) {
        delegate?.cartItemCellDidUpdateName(self, didUpdateName: textField.text)
    }
    
    @objc private func countTextFieldDidChange(_ textField: UITextField) {
        if let countText = textField.text, let count = Int(countText) {
            delegate?.cartItemCellDidUpdateCount(self, didUpdateCount: count)
        }
    }
    
    func configure(with cartItem: CartItem) {
        // 데이터 구성 메소드
        nameTextField.text = cartItem.name
        countTextField.text = "\(cartItem.count)"
    }
}

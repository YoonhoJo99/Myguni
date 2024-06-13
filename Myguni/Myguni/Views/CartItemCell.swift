//
//  CartItemCell.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import UIKit
import Then
import SnapKit

final class CartItemCell: UITableViewCell {
    
    
    private let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 8
    }
    
    // 이름 입력 필드
    private let nameTextField = UITextField().then {
        $0.placeholder = "이름"
    }

    // 수량 입력 필드
    private let countTextField = UITextField().then {
        $0.placeholder = "1"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(countTextField)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        countTextField.snp.makeConstraints { make in
            make.height.equalTo(nameTextField)
        }
    }
    
    func configure(with cartItem: CartItem) {

    }
}

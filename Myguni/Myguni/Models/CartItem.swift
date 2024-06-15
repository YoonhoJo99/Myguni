//
//  CartItem.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import RealmSwift

class CartItem: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var count: Int = 0
    
    convenience init(name: String, count: Int) {
        self.init()
        self.name = name
        self.count = count
    }
}


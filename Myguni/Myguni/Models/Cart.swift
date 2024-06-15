//
//  Cart.swift
//  Myguni
//
//  Created by 조윤호 on 6/15/24.
//

import RealmSwift

class Cart: Object {
    @objc dynamic var title: String = ""
    var items = List<CartItem>()
}

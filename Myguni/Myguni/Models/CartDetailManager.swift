//
//  CartDetailManager.swift
//  Myguni
//
//  Created by 조윤호 on 6/15/24.
//

import RealmSwift

final class CartDetailManager {
    
    // Realm 인스턴스
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Failed to access Realm database: \(error)")
        }
    }
    
    // 카트의 세부 정보를 수정하는 메서드
    func editCartDetail(_ cart: Cart, newTitle: String, newItems: [CartItem]) {
        do {
            try realm.write {
                cart.title = newTitle
                
                // 기존 항목들을 제거하고 새로운 항목들로 교체
                cart.items.removeAll()
                cart.items.append(objectsIn: newItems)
            }
        } catch {
            print("Failed to edit cart detail: \(error)")
        }
    }
    
    // 선택한 Cart 객체의 title과 일치하는 항목을 삭제하는 메서드
    func deleteCartWithTitle(_ title: String) {
        do {
            guard let cartToDelete = realm.objects(Cart.self).filter("title == %@", title).first else {
                print("Cart with title \(title) not found")
                return
            }
            
            try realm.write {
                realm.delete(cartToDelete)
            }
        } catch {
            print("Failed to delete cart: \(error)")
        }
    }
}



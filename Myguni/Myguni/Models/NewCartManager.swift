//
//  NewCartManager.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import RealmSwift

final class NewCartManager {
    
    // Realm에 데이터 저장하는 메소드
    func saveData(_ title: String?, _ items: [CartItem]) {
        guard let realm = try? Realm() else {
            print("Failed to access Realm database")
            return
        }
        
        // Realm 트랜잭션 시작
        do {
            try realm.write {
                // 기존 데이터 삭제
//                realm.deleteAll()
                
                // 새로운 Cart 객체 생성
                let cart = Cart()
                cart.title = title ?? ""
                
                // CartItemRealm으로 변환 후 추가
                let cartItems = items.map { CartItem(name: $0.name, count: $0.count) }
                cart.items.append(objectsIn: cartItems)
                
                // Realm에 저장
                realm.add(cart)
            }
            print("Data saved successfully")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}


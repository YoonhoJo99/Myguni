//
//  NewCartManager.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import RealmSwift

final class NewCartManager {
    
    // Realm에 데이터 저장하는 메소드
    func saveData(_ title: String?, completion: @escaping (Bool) -> Void) {
        guard let realm = try? Realm() else {
            print("Failed to access Realm database")
            completion(false)
            return
        }
        
        // Realm 트랜잭션 시작
        do {
            try realm.write {
                // 중복된 title을 가진 Cart 객체 검색
                if realm.objects(Cart.self).filter("title == %@", title ?? "").first != nil {
                    // 중복 발생 -> 저장 실패
                    completion(false)
                    return
                }
                
                // 새로운 Cart 객체 생성
                let cart = Cart()
                cart.title = title ?? ""
                
                // Realm에 저장
                realm.add(cart)
                completion(true)
            }
            print("Data saved successfully")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
            completion(false)
        }
    }
}



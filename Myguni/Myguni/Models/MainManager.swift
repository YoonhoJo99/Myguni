//
//  MainManager.swift
//  Myguni
//
//  Created by 조윤호 on 6/13/24.
//

import RealmSwift

final class MainManager {
    
    // Realm에 접근하기 위한 인스턴스
    private let realm: Realm
    
    // Realm 인스턴스를 외부에서 접근할 수 있는 프로퍼티
    var realmInstance: Realm? {
        do {
            // Realm 인스턴스 초기화
            let realm = try Realm()
            return realm
        } catch {
            print("Failed to access Realm database: \(error)")
            return nil
        }
    }

    init() {
        // Realm 인스턴스 초기화
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Failed to access Realm database: \(error)")
        }
    }
    
    // 저장한 카트를 가져오는 메소드
    func getAllCarts() -> Results<Cart> {
        return realm.objects(Cart.self)
    }
    
    // 저장한 카트의 개수를 반환하는 메소드
    func numberOfCarts() -> Int {
        return realm.objects(Cart.self).count
    }
}

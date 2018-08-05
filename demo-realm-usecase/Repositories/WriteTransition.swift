//
//  WriteTransition.swift
//  demo-realm-usecase
//
//  Created by NishiokaKohei on 2018/08/06.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import Foundation
import RealmSwift

/// 書き込み, 更新, 削除のときに必ず呼び出す
final class WriteTransaction {

    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    // Struct でトランジションを実行する
    public func add<T: Persistable>(_ value: T, update: Bool = true) {
        realm.add(value.managed, update: update)
    }

    public func delete<T: Persistable>(_ value: T) {
        realm.delete(value.managed)
    }

    // Deletes all objects from the Realm.
    public func deleteAll() {
        realm.deleteAll()
    }

    public func update<T: Persistable>(_ type: T.Type, values: [T.PropertyType]) {
        var dictionary = [String: Any]()
        values.forEach {
            let pair = $0.propertyValuePair
            dictionary[pair.key] = pair.value
        }
        realm.create(T.ManagedObject.self, value: dictionary, update: true)
    }

}

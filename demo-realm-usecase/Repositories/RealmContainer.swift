//
//  RealmContainer.swift
//  demo-realm-usecase
//
//  Created by NishiokaKohei on 2018/08/06.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmContainer {

    private let realm: Realm

    init(_ realm: Realm) {
        self.realm = realm
    }

    init() throws {
        try self.init(Realm())
    }

    // execute a transaction with block.
    public func write(_ block: (WriteTransaction) throws -> Void) throws {
        let transaction = WriteTransaction(realm: realm)
        do {
            try realm.write {
                try block(transaction)
            }
        } catch {
            realm.cancelWrite()
            print("failed to write")
        }
    }

    // retrive results which consists of Struct type.
    public func values<T: Persistable> (_ type: T.Type) -> FetchedResults<T> {
        let results = realm.objects(T.ManagedObject.self)
        return FetchedResults(results: results)
    }

}

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

/// データ取得用のラッパークラス
final class FetchedResults<T: Persistable> {

    private let results: Results<T.ManagedObject>

    public var count: Int {
        return results.count
    }

    init(results: Results<T.ManagedObject>) {
        self.results = results
    }

//    public func value(at index: Int) -> T {
//        return T(results[index])
//    }

//    public func valus() -> [T] {
//        return results.sorted(byKeyPath: "name", ascending: true).map({ T($0) })
//    }

}

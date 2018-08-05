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

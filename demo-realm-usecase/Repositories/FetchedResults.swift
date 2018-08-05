//
//  FetchedResults.swift
//  demo-realm-usecase
//
//  Created by NishiokaKohei on 2018/08/06.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import Foundation
import RealmSwift

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

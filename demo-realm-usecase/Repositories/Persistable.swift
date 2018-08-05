//
//  Persistable.swift
//  demo-realm-usecase
//
//  Created by NishiokaKohei on 2018/08/05.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistable {
    associatedtype T
    init(_ model: T)
    func managed(_ realmObject: Object) -> T
}

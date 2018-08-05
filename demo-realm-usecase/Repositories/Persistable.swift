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
    associatedtype ManagedObject
    associatedtype PropertyType: PropertyValueType
    var managed: ManagedObject { get }
    init(managed object: ManagedObject)
}

typealias PropertyValuePair = (key: String, value: Any)

protocol PropertyValueType {
    var propertyValuePair: PropertyValuePair { get set }
}

//
//  User.swift
//  demo-realm-usecase
//
//  Created by NishiokaKohei on 2018/08/06.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import Foundation
import RealmSwift

struct User: Persistable {
    typealias ManagedObject = UserObject
    typealias PropertyType = UserPropertyType

    var name: String
    var age: Int
    var birthday: Date

    init(managed object: UserObject) {
        self.name       = object.name
        self.age        = object.age
        self.birthday   = object.birthday
    }

    var managed: UserObject {
        let object = UserObject()
        object.name = self.name
        object.age = self.age
        object.birthday = self.birthday

        return object
    }
}

enum UserPropertyType: PropertyValueType {
    case name(String)
    case age(Int)
    case birtday(Date)

    var propertyValuePair: PropertyValuePair {
        switch self {
        case .name(let name):
            return ("name", name)
        case .age(let age):
            return ("age", age)
        case .birtday(let birthday):
            return ("birthday", birthday)
        }
    }

}


final class UserObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = -1
    @objc dynamic var birthday: Date = Date()

    override class func primaryKey() -> String? {
        return "name"
    }
}

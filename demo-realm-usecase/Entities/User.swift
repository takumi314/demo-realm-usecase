//
//  User.swift
//  demo-realm-usecase
//
//  Created by NishiokaKohei on 2018/08/06.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import Foundation
import RealmSwift

struct User {
    var name: String
    var age: Int
    var birthday: Date
}

class UserObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = -1
    @objc dynamic var birthday: Date = Date()
}

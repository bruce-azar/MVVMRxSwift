//
//  RMTodo.swift
//  RealmPlatform
//
//  Created by Mobdev125 on 2/13/18.
//  Copyright © 2018 Mobdev125. All rights reserved.
//

import QueryKit
import Domain
import RealmSwift
import Realm

final class RMTodo: Object {
    
    @objc dynamic var completed: Bool = false
    @objc dynamic var title: String = ""
    @objc dynamic var uid: String = ""
    @objc dynamic var userId: String = ""
    
    override class func primaryKey() -> String? {
        return "uid"
    }
}

extension RMTodo {
    static var title: Attribute<String> { return Attribute("title")}
    static var completed: Attribute<Bool> { return Attribute("completed")}
    static var userId: Attribute<String> { return Attribute("userId")}
    static var uid: Attribute<String> { return Attribute("uid")}
}

extension RMTodo: DomainConvertibleType {
    func asDomain() -> Todo {
        return Todo(completed: completed,
                    title: title,
                    uid: uid,
                    userId: userId)
    }
}

extension Todo: RealmRepresentable {
    func asRealm() -> RMTodo {
        return RMTodo.build { object in
            object.uid = uid
            object.userId = userId
            object.title = title
            object.completed = completed
        }
    }
}


//
//  Post+Mapping.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 2/13/18.
//  Copyright © 2018 Mobdev125. All rights reserved.
//

import Domain
import ObjectMapper

extension Post: ImmutableMappable, Identifiable {
    
    // JSON -> Object
    public init(map: Map) throws {
        body = try map.value("body")
        title = try map.value("title")
        uid = try map.value("id", using: UidTransform())
        userId = try map.value("userId", using: UidTransform())
        createdAt = (try? map.value("createdAt", using: UidTransform())) ?? ""
    }
}

extension Post: Encodable {
    var encoder: NETPost {
        return NETPost(with: self)
    }
}

final class NETPost: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let body = "body"
        static let title = "title"
        static let uid = "uid"
        static let userId = "userId"
        static let createdAt = "createdAt"
    }
    let body: String
    let title: String
    let uid: String
    let userId: String
    let createdAt: String
    
    init(with domain: Post) {
        self.body = domain.body
        self.title = domain.title
        self.uid = domain.uid
        self.userId = domain.userId
        self.createdAt = domain.createdAt
    }
    
    init?(coder aDecoder: NSCoder) {
        guard
            let body = aDecoder.decodeObject(forKey: Keys.body) as? String,
            let title = aDecoder.decodeObject(forKey: Keys.title) as? String,
            let uid = aDecoder.decodeObject(forKey: Keys.uid) as? String,
            let userId = aDecoder.decodeObject(forKey: Keys.userId) as? String,
            let createdAt = aDecoder.decodeObject(forKey: Keys.createdAt) as? String
            else {
                return nil
        }
        self.body = body
        self.title = title
        self.uid = uid
        self.userId = userId
        self.createdAt = createdAt
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(body, forKey: Keys.body)
        aCoder.encode(title, forKey: Keys.title)
        aCoder.encode(uid, forKey: Keys.uid)
        aCoder.encode(userId, forKey: Keys.userId)
        aCoder.encode(createdAt, forKey: Keys.createdAt)
    }
    
    func asDomain() -> Post {
        return Post(body: body,
                    title: title,
                    uid: uid,
                    userId: userId,
                    createdAt: createdAt)
    }
}

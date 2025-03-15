//
//  Song.swift
//  VaporServer
//
//  Created by praveen-12298 on 15/02/25.
//

import Vapor
import Fluent

///Using `**@unchecked Sendable**` to avoid Swift-6 warning
///Stored property '\_id' of 'Sendable'-conforming class 'Song' is mutable; this is an error in the Swift 6 language mode
///We are bypassing the sendable check (must ensure that value is not mutated in future)
final class Song : Model, Content,@unchecked Sendable{
    static let schema: String = "songs"

    @ID(custom: .id)
    var id: UUID? //TODO: If non UUID type provided, then the DB not creating ID.

    @Field(key: "title")
    var title: String

    init() {}

    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}

final class SongQuery : Content,@unchecked Sendable{
    var title:String?
}

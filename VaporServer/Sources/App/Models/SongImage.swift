//
//  SongImage.swift
//  VaporServer
//
//  Created by praveen-12298 on 15/03/25.
//

import Vapor
import Fluent

final class SongImage : Model, Content,@unchecked Sendable{
    static let schema: String = "songsImage"

    @ID(custom: .id)
    var id: UUID? //TODO: If non UUID type provided, then the DB not creating ID.

    @Field(key: "title")
    var title: String

    @Field(key:"image")
    var image: Data

    init() {}

//    init(id: UUID? = nil, title: String) {
//        self.id = id
//        self.title = title
//    }

    init(id: UUID? = nil,title:String,image:Data){
        self.id = id
        self.title = title
        self.image = image
    }
}

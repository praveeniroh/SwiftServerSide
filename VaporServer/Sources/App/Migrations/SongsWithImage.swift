//
//  SongsWithImage.swift
//  VaporServer
//
//  Created by praveen-12298 on 15/03/25.
//

import Fluent

struct SongsWithImage : Migration{
    private let scheme = "songsImage"
    func prepare(on database: any FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema(scheme)
            .id()
            .field("title", .string, .required)
            .field("image",.data,.required)
            .create()
    }

    func revert(on database: any FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema(scheme)
            .delete()
    }
}

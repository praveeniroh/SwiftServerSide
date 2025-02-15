//
//  CreateSongs.swift
//  VaporServer
//
//  Created by praveen-12298 on 15/02/25.
//

import Fluent

struct CreateSongs : Migration{
    private let scheme = "songs"
    func prepare(on database: any FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema(scheme)
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema(scheme)
            .delete()
    }
}

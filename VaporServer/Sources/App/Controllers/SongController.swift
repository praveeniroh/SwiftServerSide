//
//  SongController.swift
//  VaporServer
//
//  Created by praveen-12298 on 15/02/25.
//

import Fluent
import Vapor

struct SongController : RouteCollection{
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let songs = routes.grouped("songs")
        songs.get(use: index)
    }

    @Sendable
    private func index(request:Request) throws -> EventLoopFuture<[Song]> {
        return Song.query(on: request.db).all()
    }
}

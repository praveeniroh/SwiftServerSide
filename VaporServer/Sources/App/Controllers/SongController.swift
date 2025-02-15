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
        songs.post(use: create)
    }

    @Sendable
    private func index(request:Request) throws -> EventLoopFuture<[Song]> {
        return Song.query(on: request.db).all()
    }

    @Sendable
    private func create(request:Request) throws -> EventLoopFuture<HTTPStatus> {
        let song = try request.content.decode(Song.self)
        return song.create(on: request.db)
            .transform(to: .ok) //Returning HTTTP 200
    }
}

//
//  SongImageController.swift
//  VaporServer
//
//  Created by praveen-12298 on 15/03/25.
//

import Fluent
import Vapor

struct SongImageController : RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let song = routes.grouped("songimage")
        //Using 1MB for buffer size
        song.on(.POST, "",body:.collect(maxSize: .init(value: 1*1024*1024)), use: create(request:))
    }

    @Sendable
    private func create(request:Request) throws -> EventLoopFuture<HTTPStatus> {
        let song = try request.content.decode(SongImage.self)
        return song.create(on: request.db).transform(to: .ok)
    }
}

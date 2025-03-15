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
        songs.put(use: update)
        songs.group(":id"){song in
            song.delete(use: delete(request:))
        }

        ///http://127.0.0.1:8080/songs/demo/<any value>
        ///We can parse the dynamic content
        songs.get("demo",":author", use: {request in
            let author = request.parameters.get("author") ?? "**"
            return "Author of the song is \(author)"
        })
        .description("This is description")

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

    @Sendable
    private func update(request:Request) throws -> EventLoopFuture<HTTPStatus> {
        let song = try request.content.decode(Song.self)
        return Song.find(song.id, on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.title = song.title
                return $0.update(on: request.db).transform(to: .ok)
            }
    }

    ///DELETE songs/<song id>
    @Sendable
    private func delete(request:Request) throws -> EventLoopFuture<HTTPStatus> {
        return Song.find(request.parameters.get("id"), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.delete(on: request.db).transform(to: .ok)
            }

    }
}

import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: SongController())
    try app.register(collection: SongImageController())

    //`app.routes.all` prints all routes
    print(app.routes.all)
}

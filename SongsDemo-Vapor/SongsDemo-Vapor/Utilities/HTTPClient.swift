//
//  HTTPClient.swift
//  SongsDemo-Vapor
//
//  Created by praveen-12298 on 15/02/25.
//

import Foundation

enum HTTPError : Error{
    case invalidURL
    case invalidResponse
    case invalidData
}


struct HTTPClient {
    static let shared = HTTPClient()

    private init(){}

    func fetchData<T>(from url:URL) async throws -> T where T:Decodable {
        let (data, reponse) = try await URLSession.shared.data(from: url)
        guard let httpResponse = reponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw HTTPError.invalidResponse
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

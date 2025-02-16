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

enum HttpMethod: String {
    case POST, GET, PUT, DELETE
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeader: String {
    case contentType = "Content-Type"
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

    func postData<T:Codable>(to url:URL,objec:T,method:HttpMethod) async throws{
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HttpHeader.contentType.rawValue)
        request.httpBody = try JSONEncoder().encode(objec)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpReponse = response as? HTTPURLResponse, httpReponse.statusCode == 200 else {
            throw HTTPError.invalidResponse
        }
    }
}

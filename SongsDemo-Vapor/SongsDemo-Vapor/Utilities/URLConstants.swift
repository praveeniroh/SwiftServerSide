//
//  URLConstants.swift
//  SongsDemo-Vapor
//
//  Created by praveen-12298 on 15/02/25.
//

import Foundation

let hostName: String = "192.168.1.6"
let port: Int = 8080
let baseURL: String = "http://\(hostName):\(port)"

enum Endpoint {
    case songs
    case custom(String)

    var value:String{
        switch self {
        case .songs:
            return "songs"
        case .custom(let string):
            return string
        }
    }
}


func generateURL(for endpoints: [Endpoint]) throws -> URL {
    guard !endpoints.isEmpty else{
        throw HTTPError.invalidURL
    }
    var path:String = ""
    for endpoint in endpoints {
        path.append("/\(endpoint.value)")
    }

    guard let url = URL(string: "\(baseURL)\(path)") else {
        throw HTTPError.invalidURL
    }
    return url
}

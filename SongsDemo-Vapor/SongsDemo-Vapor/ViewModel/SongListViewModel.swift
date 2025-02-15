//
//  SongListViewModel.swift
//  SongsDemo-Vapor
//
//  Created by praveen-12298 on 15/02/25.
//

import Foundation

class SongListViewModel : ObservableObject {
    @Published var songs: [Song] =  [
        .init(id: UUID(), title: "New york nagaram"),
        .init(id: UUID(), title: "Mudhal nee mudivum nee")
    ]

    func fetchSongs() async throws -> [Song]{
        do{
            let url = try generateURL(for: [.songs])
            let songs : [Song] = try await HTTPClient.shared.fetchData(from: url)
            return songs
        }catch{
            print(">>> Error: \(error)")
            return [
                .init(id: UUID(), title: "New york nagaram"),
                .init(id: UUID(), title: "Mudhal nee mudivum nee")
            ]
        }
    }
}

//
//  SongListViewModel.swift
//  SongsDemo-Vapor
//
//  Created by praveen-12298 on 15/02/25.
//

import Foundation

@MainActor
class SongListViewModel : ObservableObject {
    @Published var songs: [Song] =  []

    func fetchSongs() async throws{
        do{
            let url = try generateURL(for: [.songs])
            let songs : [Song] = try await HTTPClient.shared.fetchData(from: url)
            self.songs = songs
        }catch{
            print(">>> Error: \(error)")
            throw error
        }
    }
}

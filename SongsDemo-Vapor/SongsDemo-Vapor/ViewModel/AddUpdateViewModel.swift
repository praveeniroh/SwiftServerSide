//
//  AddUpdateViewModel.swift
//  SongsDemo-Vapor
//
//  Created by praveen-12298 on 16/02/25.
//

import Foundation

@MainActor
final class AddUpdateViewModel : ObservableObject {
    @Published var songName: String = ""

    var uuid: UUID?

    var isUpdating : Bool {
        uuid != nil
    }

    init(){}

    init(song:Song){
        songName = song.title
        uuid = song.id
    }

    func addUpdateSong(completion: @escaping () -> Void) {
        Task{
            do{
                if isUpdating{
                    try await updateSong()
                }else{
                    try await addSong()
                }
                completion()
            }catch{
                print(">>> addUpdateSong error: \(error)")
            }
        }

    }

    private func addSong() async throws{
        guard !songName.isEmpty else{
            throw SongError.emptyName
        }
        let song = Song(id: nil, title: songName)
        let url = try generateURL(for: [.songs])
        try await HTTPClient.shared.postData(to: url, objec: song, method: .POST)
    }

    private func updateSong() async throws{

        guard !songName.isEmpty else{
            throw SongError.emptyName
        }

        do{
            let song = Song(id: uuid, title: songName)
            let url = try generateURL(for: [.songs])
            try await HTTPClient.shared.updateData(to: url, object: song, method: .PUT)

        }catch{
            print(">>> updateSong error: \(error)")
            throw error
        }
    }
}

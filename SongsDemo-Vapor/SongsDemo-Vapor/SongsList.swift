//
//  ContentView.swift
//  SongsDemo-Vapor
//
//  Created by praveen-12298 on 15/02/25.
//

import SwiftUI

struct SongsList: View {
    @StateObject var viewModel = SongListViewModel()
    var body: some View {
        NavigationSplitView(sidebar: {
            List(viewModel.songs, id: \.id) { song in
                Text(song.title)
            }
            .navigationTitle("Songs")
            .refreshable {
                try? await viewModel.fetchSongs()
            }
        }, detail: {
            Color.gray
        })
        .navigationSplitViewStyle(.balanced)
        .task {
            try? await viewModel.fetchSongs()
        }

    }
}

#Preview {
    SongsList()
}

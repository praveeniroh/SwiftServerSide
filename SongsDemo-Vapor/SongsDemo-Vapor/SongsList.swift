//
//  ContentView.swift
//  SongsDemo-Vapor
//
//  Created by praveen-12298 on 15/02/25.
//

import SwiftUI

struct SongsList: View {
    @StateObject var viewModel = SongListViewModel()
    @State var modal: ModalType? = nil
    var body: some View {
        NavigationSplitView(sidebar: {
            List(viewModel.songs, id: \.id) { song in
                Text(song.title)
            }
            .navigationTitle("Songs")
            .refreshable {
                try? await viewModel.fetchSongs()
            }
            .toolbar{
                Button(action: {
                    modal = .add
                }){
                    Label("Add Song button", systemImage: "plus.circle")
                }
            }
        }, detail: {
            Color.gray
        })
        .navigationSplitViewStyle(.balanced)
        .task {
            try? await viewModel.fetchSongs()
        }
        .sheet(item: $modal, onDismiss: {
            print(">>>> sheet dismiss")
            Task{
                try? await viewModel.fetchSongs()
            }
        }, content: {modal in
            switch modal{
            case .add:
                AddUpdateView()
            case .update(_):
                AddUpdateView()
            }
        })
    }
}

#Preview {
    SongsList()
}


enum ModalType:Identifiable{
    case add
    case update(Song)

    var id: String {
        switch self {
        case .add:
            return "add"
        case .update:
            return "update"
        }
    }
}

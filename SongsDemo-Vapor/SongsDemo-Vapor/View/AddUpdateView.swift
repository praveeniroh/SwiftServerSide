//
//  AddUpdateView.swift
//  SongsDemo-Vapor
//
//  Created by praveen-12298 on 16/02/25.
//

import SwiftUI

struct AddUpdateView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AddUpdateViewModel = .init()
    var body: some View {
        NavigationView{
            VStack{
                TextField("Song Name", text: $viewModel.songName)
                    .padding(10)
                    .border(.gray, width: 1)
                    .padding(16)
                Spacer()


            }
            .navigationTitle(viewModel.isUpdating ? "Update Song" : "Add Song")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button(viewModel.isUpdating ? "Update" : "Save", action: {
                    viewModel.addUpdateSong{
                        dismiss()
                    }
                })
            })
        }
    }
}

#Preview {
    AddUpdateView()
}

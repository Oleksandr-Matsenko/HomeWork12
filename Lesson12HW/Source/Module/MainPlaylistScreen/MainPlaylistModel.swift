//
//  MainPlaylistModel.swift
//  Lesson12HW
//

//

import Foundation

protocol MainPlaylistModelDelegate: AnyObject {
    func dataDidLoad()
}

// Model class responsible for loading data for the main playlist
class MainPlaylistModel {
    weak var delegate: MainPlaylistModelDelegate?
    let dataLoader = DataLoaderService()
    var items: [Song] = []
    // Method to load data for the main playlist
    func loadData() {
        // Call the data loader service to load the playlist
        dataLoader.loadPlaylist { playlist in
            self.items = playlist?.songs ?? []
            // Notify the delegate that data has been loaded
            self.delegate?.dataDidLoad()
        }
    }
}

//
//  PlaylistDeleteModel.swift
//  Lesson12HW
//

//
import Foundation

protocol PlaylistDeleteModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistDeleteModel {
    
    // MARK: - Properties
    
    weak var delegate: PlaylistDeleteModelDelegate?
    private let dataLoader = DataLoaderService()
    var items: [Song] = []
    
    // MARK: - Data Loading
    
    func loadData() {
        // Load playlist data using DataLoaderService
        dataLoader.loadPlaylist { playlist in
            // Check if playlist data is available
            if let playlist = playlist {
                // Assign playlist songs to the items array
                self.items = playlist.songs
                // Notify the delegate that data has been loaded
                self.delegate?.dataDidLoad()
            }
        }
    }
}


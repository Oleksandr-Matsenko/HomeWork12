//
//  PlaylistModesModel.swift
//  Lesson12HW
//

//import Foundation

// MARK: - Model Delegate Protocol

protocol PlaylistModesModelDelegate: AnyObject {
    func dataDidLoad(songs: [Song], songsByGenre: [String: [Song]], songsByAuthor: [String: [Song]])
}

// MARK: - Playlist Modes Model

class PlaylistModesModel {
    
// MARK: - Properties
    
    weak var delegate: PlaylistModesModelDelegate?
    private let dataLoader = DataLoaderService()
    
// MARK: - Data Loading Methods
    
    func loadAllSongs() {
        // Load all songs from the data loader
        dataLoader.loadPlaylist { playlist in
            if let playlist = playlist {
                let songs = playlist.songs
                // Notify the delegate that data has been loaded with all songs
                self.delegate?.dataDidLoad(songs: songs, songsByGenre: [:], songsByAuthor: [:])
            }
        }
    }
    
    func loadSongsByGenre() {
        // Load playlist from the data loader
        dataLoader.loadPlaylist { playlist in
            if let playlist = playlist {
                // Group songs by genre
                let songsByGenre = Dictionary(grouping: playlist.songs) { $0.genre }
                // Notify the delegate that data has been loaded with songs grouped by genre
                self.delegate?.dataDidLoad(songs: [], songsByGenre: songsByGenre, songsByAuthor: [:])
            }
        }
    }
    
    func loadSongsByAuthor() {
        // Load playlist from the data loader
        dataLoader.loadPlaylist { playlist in
            if let playlist = playlist {
                // Group songs by author
                let songsByAuthor = Dictionary(grouping: playlist.songs) { $0.author }
                // Notify the delegate that data has been loaded with songs grouped by author
                self.delegate?.dataDidLoad(songs: [], songsByGenre: [:], songsByAuthor: songsByAuthor)
            }
        }
    }
}

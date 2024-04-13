//
//  PlaylistModesModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistModesModelDelegate: AnyObject {
    func dataDidLoad(songs: [Song], songsByGenre: [String: [Song]], songsByAuthor: [String: [Song]])
}

class PlaylistModesModel {
    
    weak var delegate: PlaylistModesModelDelegate?
    private let dataLoader = DataLoaderService()
    
    func loadAllSongs() {
        dataLoader.loadPlaylist { playlist in
            if let playlist = playlist {
                let songs = playlist.songs
                self.delegate?.dataDidLoad(songs: songs, songsByGenre: [:], songsByAuthor: [:])
            }
        }
    }
    
    func loadSongsByGenre() {
        dataLoader.loadPlaylist { playlist in
            if let playlist = playlist {
                let songsByGenre = Dictionary(grouping: playlist.songs) { $0.genre }
                self.delegate?.dataDidLoad(songs: [], songsByGenre: songsByGenre, songsByAuthor: [:])
            }
        }
    }
    func loadSongsByAuthor() {
        dataLoader.loadPlaylist { playlist in
            if let playlist = playlist {
                let songsByAuthor = Dictionary(grouping: playlist.songs) { $0.author }
                self.delegate?.dataDidLoad(songs: [], songsByGenre: [:], songsByAuthor: songsByAuthor)
            }
        }
    }
}

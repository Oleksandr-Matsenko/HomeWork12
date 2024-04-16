//
//  PlaylistByGenreModel.swift
//  Lesson12HW
//

//
import Foundation

// MARK: - Protocol Declaration

protocol PlaylistByGenreModelDelegate: AnyObject {
    func dataDidLoad()
}

// MARK: - Playlist By Genre Model

class PlaylistByGenreModel {
    
    // MARK: - Properties
    
    weak var delegate: PlaylistByGenreModelDelegate?
    let dataLoader = DataLoaderService()
    var sections: [Section] = []
    
    // MARK: - Data Loading Method
    
    func loadData(genres: [String]) {
        // Load playlist from the data loader
        dataLoader.loadPlaylist { playlist in
            if let songs = playlist?.songs {
                // Group songs by genre
                let groupedSongs = Dictionary(grouping: songs) { $0.genre }
                
                // Create sections from grouped songs
                let songSections: [Section] = groupedSongs.compactMap { key, value in
                    return Section(title: key, rows: value)
                }
                
                // Update model's sections
                self.sections = songSections
                
                // Notify the delegate that data has been loaded
                self.delegate?.dataDidLoad()
            }
        }
    }
}

// MARK: - Section Model

class Section {
    var title: String
    var rows: [Song]
    
    init(title: String, rows: [Song]) {
        self.title = title
        self.rows = rows
    }
}


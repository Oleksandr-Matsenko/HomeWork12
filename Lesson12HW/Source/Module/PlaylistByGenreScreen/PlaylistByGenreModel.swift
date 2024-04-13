//
//  PlaylistByGenreModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistByGenreModelDelegate: AnyObject {
    func dataDidLoad()
    
}

class PlaylistByGenreModel {
    
    weak var delegate: PlaylistByGenreModelDelegate?
       let dataLoader = DataLoaderService()
       var sections: [Section] = []
       
    func loadData(genres: [String]) {
        dataLoader.loadPlaylist { playlist in
               if let songs = playlist?.songs {
                   
                   let groupedSongs = Dictionary(grouping: songs) { $0.genre }
                 
                   let songSections: [Section] = groupedSongs.compactMap { key, value in
                       return Section(title: key, rows: value)
                   }
                   self.sections = songSections
                   self.delegate?.dataDidLoad()
               }
               
              
           }
       }
   }

   class Section {
       var title: String
       var rows: [Song]
       
       init(title: String, rows: [Song]) {
           self.title = title
           self.rows = rows
       }
   }


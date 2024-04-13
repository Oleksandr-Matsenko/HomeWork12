//
//  MainPlaylistModel.swift
//  Lesson12HW
//

//

import Foundation

protocol MainPlaylistModelDelegate: AnyObject {
    
    func dataDidLoad()
}

class MainPlaylistModel {

    weak var delegate: MainPlaylistModelDelegate?
    
    let dataLoader = DataLoaderService()
    
    var items: [Song] = []
    
    func loadData() {
        
        dataLoader.loadPlaylist { playlist in
            
            self.items = playlist?.songs ?? []
            self.delegate?.dataDidLoad()
        }
    }
}

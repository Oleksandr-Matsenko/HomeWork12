//
//  PlaylistMoveDeleteModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistMoveDeleteModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistMoveDeleteModel {
    
    weak var delegate: PlaylistMoveDeleteModelDelegate?
    private let dataLoader = DataLoaderService()
    var items: [Song] = []
    
    func loadData() {
        dataLoader.loadPlaylist { playlist in
            self.items = playlist?.songs ?? []
            self.delegate?.dataDidLoad()
        }
    }
}

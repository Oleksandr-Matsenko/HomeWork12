//
//  PlaylistMoveDeleteModel.swift
//  Lesson12HW
//

//
import Foundation

// MARK: - Protocol

protocol PlaylistMoveDeleteModelDelegate: AnyObject {
    func dataDidLoad()
}



class PlaylistMoveDeleteModel {
    
// MARK: - Properties
    
    weak var delegate: PlaylistMoveDeleteModelDelegate?
    private let dataLoader = DataLoaderService()
    var items: [Song] = []
    
// MARK: - Data Loading
    
    // Method to load playlist data
    func loadData() {
        dataLoader.loadPlaylist { playlist in
            
            self.items = playlist?.songs ?? []
            self.delegate?.dataDidLoad()
        }
    }
}


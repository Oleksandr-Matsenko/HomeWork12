//
//  PlaylistMoveDeleteModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistMoveDeleteModelDelegate: AnyObject {
    
}

class PlaylistMoveDeleteModel {
    
    weak var delegate: PlaylistMoveDeleteModelDelegate?
    private let dataLoader = DataLoaderService()
}

//
//  PlaylistDeleteModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistDeleteModelDelegate: AnyObject {
    
}

class PlaylistDeleteModel {
    
    weak var delegate: PlaylistDeleteModelDelegate?
    private let dataLoader = DataLoaderService()
}

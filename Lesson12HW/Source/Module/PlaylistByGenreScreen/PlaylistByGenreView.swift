//
//  PlaylistByGenreView.swift
//  Lesson12HW
//

//

import UIKit

protocol PlaylistByGenreViewDelegate: AnyObject {
    
}

class PlaylistByGenreView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: PlaylistByGenreViewDelegate?
}

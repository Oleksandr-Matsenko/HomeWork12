//
//  PlaylistModesView.swift
//  Lesson12HW
//

//

import UIKit

protocol PlaylistModesViewDelegate: AnyObject {
    
}

class PlaylistModesView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: PlaylistModesViewDelegate?
}

//
//  PlaylistMoveDeleteView.swift
//  Lesson12HW
//

//

import UIKit

protocol PlaylistMoveDeleteViewDelegate: AnyObject {
    
}

class PlaylistMoveDeleteView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: PlaylistMoveDeleteViewDelegate?
}

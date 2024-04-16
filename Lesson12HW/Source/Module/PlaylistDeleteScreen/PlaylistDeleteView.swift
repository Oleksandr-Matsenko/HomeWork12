//
//  PlaylistDeleteView.swift
//  Lesson12HW
//

//

import UIKit

protocol PlaylistDeleteViewDelegate: AnyObject {
    
}

class PlaylistDeleteView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: PlaylistDeleteViewDelegate?
}

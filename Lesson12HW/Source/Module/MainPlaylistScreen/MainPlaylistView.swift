//
//  MainPlaylistView.swift
//  Lesson12HW
//

//

import UIKit

protocol MainPlaylistViewDelegate: AnyObject {
    
}

class MainPlaylistView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: MainPlaylistViewDelegate?
}

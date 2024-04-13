//
//  MainPlaylistViewController.swift
//  Lesson12HW
//

//

import UIKit

class MainPlaylistViewController: UIViewController {
    
    @IBOutlet weak var contentView: MainPlaylistView!
    var model: MainPlaylistModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = MainPlaylistModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        customizeTableView()
    }
    private func customizeTableView() {
        contentView.tableView.separatorColor = .systemBlue
        contentView.tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension MainPlaylistViewController: MainPlaylistModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension MainPlaylistViewController: MainPlaylistViewDelegate {
    
}

extension MainPlaylistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell")
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let song = model.items[indexPath.row]
        cell.textLabel?.text = "Track: \(song.songTitle)"
        cell.textLabel?.textColor = .systemBlue
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        cell.detailTextLabel?.text = "\tAlbum: \(song.albumTitle),\n\tAuthor: \(song.author), \n\tGenre: \(song.genre)"
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = .black
        cell.detailTextLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        return cell
    }
}

extension MainPlaylistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

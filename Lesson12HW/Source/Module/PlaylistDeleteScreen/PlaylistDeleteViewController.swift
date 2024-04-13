//
//  PlaylistDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistDeleteViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistDeleteView!
    var model: PlaylistDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        customizeTableView()
    }
    
    private func setupInitialState() {
        model = PlaylistDeleteModel()
        model.loadData()
        contentView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self

    }
    private func customizeTableView() {
        contentView.tableView.separatorColor = .systemBlue
        contentView.tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension PlaylistDeleteViewController: PlaylistDeleteViewDelegate {
    
}

extension PlaylistDeleteViewController: PlaylistDeleteModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
    
}
extension PlaylistDeleteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        let song = model.items[indexPath.row]
        cell.textLabel?.text = "Track: \(song.songTitle)"
        cell.textLabel?.textColor = .systemBlue
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        cell.detailTextLabel?.text = "Author: \(song.author), \n\tGenre: \(song.genre), \n\tAlbum: \(song.albumTitle)"
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.items.remove(at: indexPath.row)
            contentView.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
extension PlaylistDeleteViewController: UITableViewDelegate {
    
}

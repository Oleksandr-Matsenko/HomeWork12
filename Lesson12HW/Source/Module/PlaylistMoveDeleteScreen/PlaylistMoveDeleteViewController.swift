//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistMoveDeleteViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    var model: PlaylistMoveDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        activateEditMode()
        customizeTableView()

    }
    
    private func setupInitialState() {
        
        model = PlaylistMoveDeleteModel()
        model.loadData()
        contentView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    private func activateEditMode() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action:#selector(deleteMoveItem))
        navigationItem.rightBarButtonItem = editButton
    }
    @objc private func deleteMoveItem() {
        contentView.tableView.isEditing.toggle()
        navigationItem.rightBarButtonItem?.title = contentView.tableView.isEditing ? "Done": "Edit"
    }
    private func customizeTableView() {
        contentView.tableView.separatorColor = .systemBlue
        contentView.tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}
extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}
extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteViewDelegate {
   
    }

// MARK: - DataSourse

extension PlaylistMoveDeleteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.items.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
          if contentView.tableView.isEditing {
              return .delete
          } else {
              return .none
          }
      }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let song = model.items.remove(at: sourceIndexPath.row)
        model.items.insert(song, at: destinationIndexPath.row)
    }
    
    }

// MARK: - Delegate
extension PlaylistMoveDeleteViewController: UITableViewDelegate {
    
}

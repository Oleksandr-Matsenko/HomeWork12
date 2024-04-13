//
//  PlaylistDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

final class PlaylistDeleteViewController: UIViewController {
    
// MARK: - Outlets
    
    @IBOutlet weak var contentView: PlaylistDeleteView!
    
// MARK: - Properties
    
    var model: PlaylistDeleteModel!
    
// MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        customizeTableView()
    }
    
// MARK: - Initial Setup
    
    private func setupInitialState() {
        // Initialize the model
        model = PlaylistDeleteModel()
        // Load data using the model
        model.loadData()
        // Set delegates and data source for the table view
        contentView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
// MARK: - Customization
    
    private func customizeTableView() {
        // Customize table view appearance
        contentView.tableView.separatorColor = .systemBlue
        contentView.tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}

// MARK: - PlaylistDeleteViewDelegate

extension PlaylistDeleteViewController: PlaylistDeleteViewDelegate {
    // Implement methods if needed
}

// MARK: - PlaylistDeleteModelDelegate

extension PlaylistDeleteViewController: PlaylistDeleteModelDelegate {
    func dataDidLoad() {
        // Reload table view data when data is loaded
        contentView.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension PlaylistDeleteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows based on the number of items in the model
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure("Failed to dequeue reusable cell")
            return UITableViewCell()
        }
        // Configure cell with song data from the model
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
        // Handle deletion of rows
        if editingStyle == .delete {
            // Remove the item from the model's data
            model.items.remove(at: indexPath.row)
            // Delete the row from the table view with animation
            contentView.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - UITableViewDelegate

extension PlaylistDeleteViewController: UITableViewDelegate {
    // Implement methods if needed
}

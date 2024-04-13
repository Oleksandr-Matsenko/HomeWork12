//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//
import UIKit

final class PlaylistMoveDeleteViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    
    // MARK: - Properties
    
    var model: PlaylistMoveDeleteModel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        activateEditMode()
        customizeTableView()
    }
    
    // MARK: - Initial Setup
    
    private func setupInitialState() {
        // Initialize the model and load data
        model = PlaylistMoveDeleteModel()
        model.loadData()
        
        // Set delegates for content view and table view
        contentView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func activateEditMode() {
        // Add an "Edit" button to the navigation bar
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action:#selector(deleteMoveItem))
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc private func deleteMoveItem() {
        // Toggle editing mode for the table view
        contentView.tableView.isEditing.toggle()
        // Update the button title based on editing mode
        navigationItem.rightBarButtonItem?.title = contentView.tableView.isEditing ? "Done": "Edit"
    }
    
    private func customizeTableView() {
        // Customize table view appearance
        contentView.tableView.separatorColor = .systemBlue
        contentView.tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteModelDelegate {
    func dataDidLoad() {
        // Reload table view data when data is loaded
        contentView.tableView.reloadData()
    }
}

extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteViewDelegate {
   
}

// MARK: - UITableViewDataSource

extension PlaylistMoveDeleteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the model
        return model.items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Only one section in this table view
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        
        // Configure cell with song information
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
        // Handle row deletion
        if editingStyle == .delete {
            model.items.remove(at: indexPath.row)
            contentView.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // Set editing style for each row based on editing mode
        if contentView.tableView.isEditing {
            return .delete
        } else {
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Handle row movement
        let song = model.items.remove(at: sourceIndexPath.row)
        model.items.insert(song, at: destinationIndexPath.row)
    }
}

// MARK: - UITableViewDelegate

extension PlaylistMoveDeleteViewController: UITableViewDelegate {
    
}

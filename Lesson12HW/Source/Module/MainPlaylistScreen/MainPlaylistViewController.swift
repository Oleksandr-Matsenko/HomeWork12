//
//  MainPlaylistViewController.swift
//  Lesson12HW
//

//

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
    
    // Sets up the initial state of the view controller
    private func setupInitialState() {
        // Initialize the model
        model = MainPlaylistModel()
        // Set the delegate of the model to this view controller
        model.delegate = self
        contentView.delegate = self
        // Set up table view data source and delegate
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        // Customize table view appearance
        customizeTableView()
    }
    
    // Customizes the appearance of the table view
    private func customizeTableView() {
        contentView.tableView.separatorColor = .systemBlue
        contentView.tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}

// MARK: - MainPlaylistModelDelegate

extension MainPlaylistViewController: MainPlaylistModelDelegate {
    
    // Called when data is loaded in the model
    func dataDidLoad() {
        // Reload table view data
        contentView.tableView.reloadData()
    }
}

// MARK: - MainPlaylistViewDelegate

extension MainPlaylistViewController: MainPlaylistViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension MainPlaylistViewController: UITableViewDataSource {
    
    // Returns the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    // Configures and returns a cell for the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure("Failed to dequeue reusable cell")
            return UITableViewCell()
        }
        
        // Configure cell with song data
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

// MARK: - UITableViewDelegate

extension MainPlaylistViewController: UITableViewDelegate {
    
}

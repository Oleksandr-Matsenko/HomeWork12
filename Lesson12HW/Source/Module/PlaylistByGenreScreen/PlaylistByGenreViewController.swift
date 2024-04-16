//
//  PlaylistByGenreViewController.swift
//  Lesson12HW
//

//

import UIKit

final class PlaylistByGenreViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var contentView: PlaylistByGenreView!
    var model: PlaylistByGenreModel!
    var playlistByGenre: [String: [Song]] = [:]
    var genres: [String] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    // MARK: - Setup
    
    private func setupInitialState() {
        // Initialize the model and set the delegate
        model = PlaylistByGenreModel()
        model.delegate = self
        
        // Set up table view data source and delegate
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        // Load data based on genres
        model.loadData(genres: genres)
        
        // Customize table view appearance
        customizeTableView()
    }
    
    private func customizeTableView() {
        // Customize table view separator color and inset
        contentView.tableView.separatorColor = .systemBlue
        contentView.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

// MARK: - Table View Delegate

extension PlaylistByGenreViewController: UITableViewDelegate {
    // Provide section header titles
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(genres[section])".uppercased()
    }
}

// MARK: - Table View Data Source

extension PlaylistByGenreViewController: UITableViewDataSource {
    // Return the number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let genre = genres[section]
        return playlistByGenre[genre]?.count ?? 0
    }
    
    // Configure and return cells for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let genre = genres[indexPath.section]
        if let songsInGenre = playlistByGenre[genre] {
            let song = songsInGenre[indexPath.row]
            configureCell(cell, with: song)
        }
        return cell
    }
    
    // Return the number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return genres.count
    }
    
    // Configure cell with song details
    private func configureCell(_ cell: UITableViewCell, with song: Song) {
        cell.textLabel?.text = "Track: \(song.songTitle)"
        cell.textLabel?.textColor = .systemBlue
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        cell.detailTextLabel?.text = "Album: \(song.albumTitle), \nAuthor: \(song.author), \nGenre: \(song.genre)"
        cell.detailTextLabel?.font = .systemFont(ofSize: 13, weight:.regular)
        cell.detailTextLabel?.numberOfLines = 0
    }
}

// MARK: - Model Delegate

extension PlaylistByGenreViewController: PlaylistByGenreModelDelegate {
    // Handle data load completion
    func dataDidLoad() {
        // Reload table view data
        contentView.tableView.reloadData()
        
        // Update genres and playlistByGenre properties
        genres = model.sections.map { $0.title }
        playlistByGenre = Dictionary(uniqueKeysWithValues: model.sections.map { ($0.title, $0.rows) })
    }
}

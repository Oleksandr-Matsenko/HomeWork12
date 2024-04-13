//
//  PlaylistModesViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistModesViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistModesView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var model: PlaylistModesModel!
    var songs: [Song] = []
    var songsByGenre: [String: [Song]] = [:]
    var songsByAuthor: [String: [Song]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        loadAllSongs()
        customizeTableView()
    }
    
    private func setupInitialState() {
        model = PlaylistModesModel()
        model.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
    }
    private func customizeTableView() {
        contentView.tableView.separatorColor = .systemBlue
        contentView.tableView.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadAllSongs()
        case 1:
            loadSongsByGenre()
        case 2:
            loadSongsByAuthor()
        default:
            break
        }
    }
    
    private func loadAllSongs() {
        model.loadAllSongs()
    }
    
    private func loadSongsByGenre() {
        model.loadSongsByGenre()
    }
    
    private func loadSongsByAuthor() {
        model.loadSongsByAuthor()
    }
}

extension PlaylistModesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return 1
        case 1:
            return songsByGenre.keys.count
        case 2:
            return songsByAuthor.keys.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return "All".uppercased()
        case 1:
            return Array(songsByGenre.keys)[section]
        case 2:
            return Array(songsByAuthor.keys)[section]
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return songs.count
        case 1:
            let genre = Array(songsByGenre.keys)[section]
            return songsByGenre[genre]?.count ?? 0
        case 2:
            let author = Array(songsByAuthor.keys)[section]
            return songsByAuthor[author]?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let song = songs[indexPath.row]
            configureCell(cell, with: song)
        case 1:
            let genre = Array(songsByGenre.keys)[indexPath.section]
            if let songsInGenre = songsByGenre[genre] {
                let song = songsInGenre[indexPath.row]
                configureCell(cell, with: song)
                cell.textLabel?.text = "Genre: \(song.genre)"
            }
        case 2:
            let author = Array(songsByAuthor.keys)[indexPath.section]
            if let songsByAuthor = songsByAuthor[author] {
                let song = songsByAuthor[indexPath.row]
                configureCell(cell, with: song)
                cell.textLabel?.text = "Author: \(song.author)"
                
            }
        default:
            break
        }
        return cell
    }
    
    private func configureCell(_ cell: UITableViewCell, with song: Song) {
        cell.textLabel?.text = "Track: \(song.songTitle)"
        cell.detailTextLabel?.text = "\tAlbum: \(song.albumTitle), \n\tAuthor: \(song.author), \n\tGenre: \(song.genre)"
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .systemBlue
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        cell.detailTextLabel?.font = .systemFont(ofSize: 13, weight: .regular)
    }
}

extension PlaylistModesViewController: PlaylistModesModelDelegate {
    func dataDidLoad(songs: [Song], songsByGenre: [String: [Song]], songsByAuthor: [String: [Song]]) {
        self.songs = songs
        self.songsByGenre = songsByGenre
        self.songsByAuthor = songsByAuthor
        contentView.tableView.reloadData()
    }
}


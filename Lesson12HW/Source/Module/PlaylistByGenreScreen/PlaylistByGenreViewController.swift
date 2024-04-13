//
//  PlaylistByGenreViewController.swift
//  Lesson12HW
//

//

import UIKit

final class PlaylistByGenreViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistByGenreView!
    var model: PlaylistByGenreModel!
    var playlistByGenre: [String: [Song]] = [:]
    var genres: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        
    }
    
    private func setupInitialState() {
        model = PlaylistByGenreModel()
        model.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        model.loadData(genres: genres)
        customizeTableView()
    }
    private func customizeTableView() {
        contentView.tableView.separatorColor = .systemBlue
        contentView.tableView.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
    }
}

extension PlaylistByGenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "\(genres[section])".uppercased()
    }
}

extension PlaylistByGenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let genre = genres[section]
        return playlistByGenre[genre]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        let genre = genres[indexPath.section]
        if let songsInGenre = playlistByGenre[genre] {
            let song = songsInGenre[indexPath.row]
            cell.textLabel?.text = "Track: \(song.songTitle)"
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
            cell.detailTextLabel?.text = "Album: \(song.albumTitle), \nAuthor: \(song.author), \nGenre: \(song.genre)"
            cell.detailTextLabel?.font = .systemFont(ofSize: 13, weight:.regular)
            cell.detailTextLabel?.numberOfLines = 0
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return genres.count
    }
}

extension PlaylistByGenreViewController: PlaylistByGenreModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
        genres = model.sections.map{$0.title}
        playlistByGenre = Dictionary(uniqueKeysWithValues: model.sections.map{($0.title, $0.rows)})
    }
}

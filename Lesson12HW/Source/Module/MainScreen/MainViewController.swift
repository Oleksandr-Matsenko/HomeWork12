//
//  MainViewController.swift
//  Lesson12HW
//

//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var contentView: MainView!
    var model: MainModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = MainModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

// MARK: - MainModelDelegate
extension MainViewController: MainModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell")
        else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = model.items[indexPath.row].title
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let type = model.items[indexPath.row].type
        var vc: UIViewController?
        
        switch type {
        case .showLsit:
            vc = MainPlaylistViewController.fromMainStoryboard()
        case .playlistDeleteItem:
            vc = PlaylistDeleteViewController.fromMainStoryboard()
        case .playlistMoveDeleteItem:
            vc = PlaylistMoveDeleteViewController.fromMainStoryboard()
        case .playlistByGenre:
            vc = PlaylistByGenreViewController.fromMainStoryboard()
        case .playlistWithModes:
            vc = PlaylistModesViewController.fromMainStoryboard()
        }
        
        guard let viewController = vc else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

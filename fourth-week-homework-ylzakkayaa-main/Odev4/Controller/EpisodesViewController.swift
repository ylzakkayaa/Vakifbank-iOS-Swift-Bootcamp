//
//  EpisodesViewController.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 26.11.2022.
//

import UIKit

class EpisodesViewController: BaseViewController {
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    private var episodes: [EpisodesModel]? {
        didSet {
            episodesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        indicator.startAnimating()
        Client.getEpisodes { [weak self] allEpisodes, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.episodes = allEpisodes
        }
    }
    //Cell'leri configure ettim.
    private func configureTableView() {
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        episodesTableView.register(UINib(nibName: "EpisodesTableViewCell", bundle: nil), forCellReuseIdentifier: "toEpisodes")
    }
}

extension EpisodesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toEpisodes", for: indexPath) as? EpisodesTableViewCell,
              let model = episodes?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configureEpisodes(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
     
    //View'ın sayfada ortalanmsaı için rame verdim.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodeCharacter = EpisodesCharactersView(frame: CGRect(x: view.frame.size.width  / 2 - 200,
                                                                    y: view.frame.size.height / 2 - 300,
                                                                    width: 400,
                                                                    height: 600), characters: episodes?[indexPath.row].characters ?? [])
        episodeCharacter.alpha = 0
        UIView.animate(withDuration: 1.0) {
            episodeCharacter.alpha = 1
        }
        episodeCharacter.delegate = self
        view.addSubview(episodeCharacter)
    }
    
}

extension EpisodesViewController: NewCharacterViewDelegate {
    func savePressed() {
        print("View closed.")
    }
}


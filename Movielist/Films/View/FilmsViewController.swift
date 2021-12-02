//
//  FilmViewController.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation
import UIKit

class FilmsViewController: UIViewController {

    //MARK: - Table View
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(FilmsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var films = [Film]()

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FilmNetworkService.getFilms { (response) in
            self.films = response.films
            self.tableView.reloadData()
        }
        
        self.tableView.tableFooterView = UIView()
        self.setNavigation()
        self.setupView()
        self.setupDelegate()
        self.setConstraints()
    }
//MARK: - Setup View

    private func setupView() {
//        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
//MARK: - Setup Delegate, DataSource

    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
//MARK: - Set Navigation Controller
    private func setNavigation() {
        self.navigationItem.title = "Фильмы"
        let navigationViewController = UINavigationController(rootViewController: FilmsViewController())
        navigationViewController.modalPresentationStyle = .pageSheet
    }
}

//MARK: - UITableView DataSource

extension FilmsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FilmsTableViewCell
        let film = films[indexPath.row]
        cell.configureFilmCell(with: film)
        return cell
    }
}

//MARK: - UITableView Delegate

extension FilmsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    
//MARK: - SetConstraints

extension FilmsViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
}

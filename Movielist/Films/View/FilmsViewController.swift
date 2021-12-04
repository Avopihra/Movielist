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
        tableView.register(FilmsTableViewCell.self, forCellReuseIdentifier: "filmsTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var films = [Film]()
    var sectionData = [Int: [Film]]()
    var sortingYears = [Int]()

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FilmNetworkService.getFilms { (response) in
            self.films = response.films
            self.sectionData = Dictionary(grouping: self.films, by: { $0.year })
            self.sortingYears = Array(self.sectionData.keys).sorted(by: <)
            self.tableView.reloadData()
        }
 
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortingYears.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.sortingYears[section]
        if let values = sectionData[key] {
            return values.count
         }
         return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .systemGray4
        let label = UILabel()
        label.frame = headerView.bounds
        label.text = "\(self.sortingYears[section])"
        label.textAlignment = .center
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = self.sortingYears[indexPath.section]
        if let values = sectionData[key]?.sorted(by: {$0.rating > $1.rating}) {
            let film = values[indexPath.row]
            let filmsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "filmsTableViewCell", for: indexPath) as! FilmsTableViewCell
            filmsTableViewCell.configureFilmCell(with: film)
            return filmsTableViewCell
         }
        
        return UITableViewCell()
    }
}
//MARK: - UITableView Delegate

extension FilmsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = FilmCardViewContoller()
        self.navigationController?.pushViewController(destination, animated: true)
    }

}
    
//MARK: - Set Constraints

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

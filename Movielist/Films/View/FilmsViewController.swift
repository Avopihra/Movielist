//
//  FilmViewController.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation
import UIKit

class FilmsViewController: UIViewController {

//MARK: - TableView
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(FilmsTableViewCell.self, forCellReuseIdentifier: "filmsTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - ImageView NoTable
    private let noTableImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.3")
        imageView.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - 50,
                                 y: UIScreen.main.bounds.size.height / 2 - 50,
                                 width: 100, height: 50)
        imageView.tintColor = .lightGray
        return imageView
    }()
    
//MARK: - UIRefreshControl
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender: )), for: .valueChanged)
        return refreshControl
    }()
    
    var films = [Film]()
    var sectionData = [Int: [Film]]()
    var sortingYears = [Int]()
    
//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.refreshControl = refreshControl
        self.setNavigation()
        self.setupView()
        self.setupNoTableImage()
        self.setupDelegate()
        self.setConstraints()
        self.getResponse(completion: {})
    }
    
//MARK: - Refresh UIRefreshControl
    @objc func refresh(sender: UIRefreshControl) {
        self.getResponse {
            DispatchQueue.main.async {
                sender.endRefreshing()
            }
        }
    }
    
//MARK: - Setup noTableImage
    private func setupNoTableImage() {
        let image = self.noTableImage
        image.isUserInteractionEnabled = true
        self.view.addSubview(image)
    }
   
//MARK: - Get Film Response
    private func getResponse(completion: @escaping() -> ()) {
        FilmsNetworkService.getFilms { (response, error) in
            guard let response = response else {
                completion()
                self.noTableImage.isHidden = false
                self.tableView.contentOffset = CGPoint.zero
                self.showAlert(title: "Что-то пошло не так ...", message: "Проверьте интернет-соединение")
                return
            }
            
            self.noTableImage.isHidden = true
            self.films = response.films
            self.sectionData = Dictionary(grouping: self.films, by: { $0.year })
            self.sortingYears = Array(self.sectionData.keys).sorted(by: <)
            self.tableView.reloadData()
            completion()
        }
    }
        
//MARK: - Setup View
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.tableView)
    }
    
//MARK: - Setup Delegate, DataSource
    private func setupDelegate() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
//MARK: - Navigation Controller Settings
    private func setNavigation() {
        self.navigationItem.title = "Фильмы"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: .none,
            style: .plain,
            target: nil,
            action: nil
        )
        let backButtonImage = UIImage(systemName: "arrow.backward")
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.layer.borderColor = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.navigationController?.navigationBar.layer.borderWidth = 0.5
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
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
    
//MARK: - Header Settings
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 16, y: 0, width: (UIScreen.main.bounds.width - 32), height: 35))
        let label = UILabel()
        headerView.addSubview(label)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.backgroundColor = .systemGray4
        label.frame = headerView.frame
        label.text = "\(self.sortingYears[section])"
        label.textAlignment = .center
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

//MARK: - UITableView Delegate
extension FilmsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = FilmCardViewContoller()
        let key = self.sortingYears[indexPath.section]
        
        if let values = sectionData[key] {
            destination.setFilm(with: values[indexPath.row])
            self.navigationController?.pushViewController(destination, animated: true)
         }
    }
}
    
//MARK: - Set Constraints
extension FilmsViewController {
    
    private func setConstraints() {
        let topPadding = UIApplication.shared.windows.first{$0.isKeyWindow }?.safeAreaInsets.top ?? 0
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let tableViewTopAnchor = topPadding + navigationBarHeight + 10
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: tableViewTopAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
            
        ])
    }
}

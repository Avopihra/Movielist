//
//  FilmsTableViewCell.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import UIKit

class FilmsTableViewCell: UITableViewCell {
    
    private let localizedName: UILabel = {
        let label = UILabel()
        label.text = "localized_name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.text = "rating"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Set Constraints
    private func setupStack() {
        let stackView = UIStackView(arrangedSubviews: [localizedName,
                                                       name,
                                                       rating],
                                                       axis: .horizontal,
                                                       spacing: 10,
                                                       distribution: .fillEqually)
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }

//MARK: - Configure
    func configureFilmCell(with film: Film) {
        self.localizedName.text = film.localized_name
        self.name.text = film.name
        self.rating.text = String(describing: film.rating)
    }
       
}

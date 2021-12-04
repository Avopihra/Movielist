//
//  FilmCardViewContoller.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation
import UIKit

class FilmCardViewContoller: UIViewController {
    
    private let name: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let year: UILabel = {
        let label = UILabel()
        label.text = "year"
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

    private let movieDescription: UILabel = {
        let label = UILabel()
        label.text = "Name album"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7823360562, green: 0.8894354701, blue: 0.9561796784, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var stackView = UIStackView()

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupStack()
        self.view.addSubview(self.moviePoster)
        self.view.addSubview(self.movieDescription)
        self.setConstraints()
    }
//
//    //MARK: - Set Navigation Controller
//
//MARK: - Set Constraints

    private func setupStack() {
        self.stackView = UIStackView(arrangedSubviews: [name,
                                                       year,
                                                       rating],
                                                       axis: .vertical,
                                                       spacing: 10,
                                                       distribution: .fillProportionally)
        self.view.addSubview(self.stackView)
    }

}

//    //MARK: - Set Constraints
extension FilmCardViewContoller {

    private func setConstraints() {

            NSLayoutConstraint.activate([
                self.moviePoster.topAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.moviePoster.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
                self.moviePoster.heightAnchor.constraint(equalToConstant: 60),
                self.moviePoster.widthAnchor.constraint(equalToConstant: 60)
            ])
    
            NSLayoutConstraint.activate([
                self.movieDescription.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
                self.movieDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
                self.movieDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
            ])

            NSLayoutConstraint.activate([
                self.stackView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10),
                self.stackView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10),
                self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
            ])
        }
}


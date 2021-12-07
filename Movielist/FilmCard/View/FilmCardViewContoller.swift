//
//  FilmCardViewContoller.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation
import UIKit
import Kingfisher

protocol FilmCardProtocol {
    func setFilm(with film: Film)
}

class FilmCardViewContoller: UIViewController, FilmCardProtocol, UIScrollViewDelegate {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.textColor = UIColor(named: "movielistGray")
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()

    private let moviePosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor =  UIColor(named: "movielistBlue")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private let noRatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.slash")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.tintColor = UIColor(named: "movielistGray")
        return imageView
    }()
    
    private var ratingLabelColor: UIColor?
    private var film: Film?
    private var attributedRatingLabel = NSMutableAttributedString()
    private var attributedRatingWord = NSAttributedString()
    
//MARK: - set ScrollView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

//MARK: - setFilm
    func setFilm(with film: Film) {
        self.film = film
    }

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [nameLabel, yearLabel, ratingLabel, movieDescription, moviePosterImage, noRatingImageView, contentView ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        self.configureNavigationBar()
        self.setScrollView()
        self.setConstraints()
        self.configureFilmCard()
    }
    
//MARK: - Setup ScrollView
    private func setScrollView() {
        self.scrollView.frame = self.view.bounds
    }
    
//MARK: - Setup RatingLabel Color
    private func setRatingLabelColor(ratingValue: RatingValue) {
        switch ratingValue {
        case .high:
            ratingLabelColor = UIColor(named: "highRatingColor")
            self.ratingLabel.textColor = ratingLabelColor
            
        case .medium:
            ratingLabelColor = UIColor(named: "mediumRatingColor")
            self.ratingLabel.textColor = ratingLabelColor
            
        case .low:
            ratingLabelColor = UIColor(named: "lowRatingColor")
            self.ratingLabel.textColor = ratingLabelColor
        }
    }
    
    //MARK: - Configure NavigationBar
    func configureNavigationBar() {
        if let navigationTitlte = self.film?.localized_name {
            self.navigationItem.title = "\(navigationTitlte)"
        }
    }
    
    //MARK: - Configure Card View
    func configureFilmCard() {
        self.view.backgroundColor = .white
        self.nameLabel.text = film?.name
        if let year = self.film?.year {
            self.yearLabel.text = "\(NSLocalizedString("Year: ", comment: ""))\(year)"
        }
        self.movieDescription.text = film?.description
        
        if let imageURL = self.film?.image_url {
            self.moviePosterImage.kf.indicatorType = .activity
            self.moviePosterImage.kf.setImage(with: URL(string: imageURL)) { (result) in
                switch result {
                case .failure(_):
                    self.moviePosterImage.image = UIImage(named: "noImage")
                
                default:
                    self.moviePosterImage.backgroundColor = UIColor(named: "movielistBlue")
                }
            }
        } else {
            self.moviePosterImage.image = UIImage(named: "noImage")
        }
        
        if let rating = film?.rating,
           rating != 0 {
            self.ratingLabel.text = "\(rating)"
            self.noRatingImageView.isHidden = true
            self.setRatingLabelColor(ratingValue: film?.ratingValue ?? .low)
            self.attributedRatingWord = NSMutableAttributedString(string: NSLocalizedString("Rating: ", comment: ""),
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            let attributedRatingValue = NSAttributedString(string: self.ratingLabel.text ?? "")
            self.attributedRatingLabel.append(attributedRatingWord)
            self.attributedRatingLabel.append(attributedRatingValue)
            self.ratingLabel.attributedText = self.attributedRatingLabel
        } else {
            self.ratingLabel.text = ""
            self.noRatingImageView.isHidden = false
        }
    }
}

//MARK: - Set Constraints
extension FilmCardViewContoller {
    
    func setConstraints() {
                
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.scrollView.addSubview(self.moviePosterImage)
        self.scrollView.addSubview(self.nameLabel)
        self.scrollView.addSubview(self.yearLabel)
        self.scrollView.addSubview(self.ratingLabel)
        self.scrollView.addSubview(self.noRatingImageView)
        self.scrollView.addSubview(self.movieDescription)
        
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            self.moviePosterImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.moviePosterImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.moviePosterImage.widthAnchor.constraint(equalToConstant: 140),
            self.moviePosterImage.heightAnchor.constraint(equalToConstant: 210),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.moviePosterImage.trailingAnchor, constant: 12),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),

            self.yearLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant:15),
            self.yearLabel.leadingAnchor.constraint(equalTo: self.moviePosterImage.trailingAnchor, constant: 12),

            self.ratingLabel.topAnchor.constraint(equalTo: self.yearLabel.bottomAnchor, constant: 15),
            self.ratingLabel.leadingAnchor.constraint(equalTo: self.moviePosterImage.trailingAnchor, constant: 12),
            
            self.noRatingImageView.topAnchor.constraint(equalTo: self.yearLabel.bottomAnchor, constant: 20),
            self.noRatingImageView.leadingAnchor.constraint(equalTo: self.moviePosterImage.trailingAnchor, constant: 15),
            self.noRatingImageView.widthAnchor.constraint(equalToConstant: 30),
            self.noRatingImageView.heightAnchor.constraint(equalToConstant: 30),

            self.movieDescription.topAnchor.constraint(equalTo: self.moviePosterImage.bottomAnchor, constant: 20),
            self.movieDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.movieDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
        ])
    }
}



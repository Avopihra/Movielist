//
//  FilmCardViewContoller.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation
import UIKit


protocol FilmCardProtocol {
    func setFilm(with film: Film)
}

class FilmCardViewContoller: UIViewController, FilmCardProtocol, UIScrollViewDelegate {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textColor = UIColor(named: "movielistGray")
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()

    private let moviePosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor =  UIColor(named: "movielistBlue")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private let noRatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.slash")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//MARK: - setFilm
    func setFilm(with film: Film) {
        self.film = film
    }

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setScrollView()
        self.setConstraints()
        self.configureFilmCard()
        self.view.backgroundColor = .white
    }
    
//MARK: - Navigation title
//    override var title: String? {
//        get {
//            return self.navigationItem.title
//        }
//        set {
//            self.navigationController?.navigationBar.titleTextAttributes = [
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
//            ]
//            self.navigationItem.title = newValue
//        }
//    }
    
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
    
//MARK: - Configure Card View
    func configureFilmCard() {
        if let navigationTitlte = self.film?.localized_name {
            self.navigationItem.title = "\(navigationTitlte)"
            
        }
        self.nameLabel.text = film?.name
        if let year = self.film?.year {
            self.yearLabel.text = "Год: \(year)"
        }
        self.movieDescription.text = film?.description
        //            self.moviePosterImage.image = film.image_url
        
        if let rating = film?.rating,
           rating != 0 {
            self.ratingLabel.text = "\(rating)"
            self.noRatingImageView.isHidden = true
            self.setRatingLabelColor(ratingValue: film?.ratingValue ?? .low)
            self.attributedRatingWord = NSMutableAttributedString(string: "Рейтинг: ",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            let attributedRatingValue = NSAttributedString(string: self.ratingLabel.text ?? "без рейтинга")
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

        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.moviePosterImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.moviePosterImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.moviePosterImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.moviePosterImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.moviePosterImage.trailingAnchor, constant: 12).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true

        self.yearLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant:15).isActive = true
        self.yearLabel.leadingAnchor.constraint(equalTo: self.moviePosterImage.trailingAnchor, constant: 12).isActive = true

        self.ratingLabel.topAnchor.constraint(equalTo: self.yearLabel.bottomAnchor, constant: 15).isActive = true
        self.ratingLabel.leadingAnchor.constraint(equalTo: self.moviePosterImage.trailingAnchor, constant: 12).isActive = true
        
        self.noRatingImageView.topAnchor.constraint(equalTo: self.yearLabel.bottomAnchor, constant: 20).isActive = true
        self.noRatingImageView.leadingAnchor.constraint(equalTo: self.moviePosterImage.trailingAnchor, constant: 15).isActive = true
        self.noRatingImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.noRatingImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        self.movieDescription.topAnchor.constraint(equalTo: self.moviePosterImage.bottomAnchor, constant: 30).isActive = true
        self.movieDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.movieDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
    }
}



//
//  FilmsTableViewCell.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import UIKit

class FilmsTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.cgColor
        return containerView
    }()
    
    private let localizedNameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    private let noRatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: UIScreen.main.bounds.width - 50, y: 10, width: 30, height: 30)
        imageView.image = UIImage(systemName: "star.slash")
        imageView.contentMode = .center
        imageView.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return imageView
    }()
    
    private var ratingLabelColor: UIColor? = .clear

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.setNeedsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRatingLabelColor(ratingValue: RatingValue) {
        switch ratingValue {
        case .high:
            ratingLabelColor = UIColor(red: 0/255, green: 123/255, blue: 0/255, alpha: 1.0)
            self.ratingLabel.textColor = ratingLabelColor
            
        case .medium:
            ratingLabelColor = UIColor(red: 95/255, green: 95/255, blue: 95/255, alpha: 1.0)
            self.ratingLabel.textColor = ratingLabelColor
            
        case .low:
            ratingLabelColor = UIColor(red: 255/255, green: 11/255, blue: 11/255, alpha: 1.0)
            self.ratingLabel.textColor = ratingLabelColor
        }
    }

//MARK: - Configure Cell
    func configureFilmCell(with film: Film) {
        self.setConstraints()
        self.addSubview(noRatingImageView)
        self.localizedNameLabel.text = film.localized_name
        self.nameLabel.text = film.name
        if film.rating != 0 {
        self.ratingLabel.text = String(describing: film.rating)
            self.noRatingImageView.isHidden = true
            self.setRatingLabelColor(ratingValue: film.ratingValue ?? .low)
        } else {
            self.ratingLabel.text = ""
            self.noRatingImageView.isHidden = false
        }
    }
}

extension FilmsTableViewCell {
    
    private func setConstraints() {
        
        let marginGuide = contentView.layoutMarginsGuide
  
        contentView.addSubview(self.containerView)
        containerView.addSubview(self.ratingLabel)
        containerView.addSubview(self.localizedNameLabel)
        containerView.addSubview(self.nameLabel)

        self.containerView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: -6).isActive = true
        self.containerView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true

        self.ratingLabel.topAnchor.constraint(equalTo: self.localizedNameLabel.topAnchor).isActive = true
        self.ratingLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -12).isActive = true
        self.ratingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        self.ratingLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
        self.localizedNameLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 12).isActive = true
        self.localizedNameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 12).isActive = true
        self.localizedNameLabel.trailingAnchor.constraint(equalTo: self.ratingLabel.leadingAnchor).isActive = true
        
        self.nameLabel.topAnchor.constraint(equalTo: self.localizedNameLabel.bottomAnchor, constant: 12).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 12).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -12).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -12).isActive = true
        
        self.setNeedsLayout()
    }
}

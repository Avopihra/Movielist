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
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.text = "rating"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
  
        self.selectionStyle = .none
        self.setConstraints()
        self.setNeedsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - Configure
    func configureFilmCell(with film: Film) {
        self.addSubview(noRatingImageView)
        self.localizedName.text = film.localized_name
        self.name.text = film.name
        if film.rating != 0 {
        self.rating.text = String(describing: film.rating)
            self.noRatingImageView.isHidden = true
        } else {
            self.rating.text = ""
            self.noRatingImageView.isHidden = false
        }
    }
}

extension FilmsTableViewCell {
    
    private func setConstraints() {
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(rating)
        contentView.addSubview(localizedName)
        contentView.addSubview(name)
        
        self.rating.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        self.rating.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 5).isActive = true
        self.rating.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        self.rating.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        
        self.localizedName.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        self.localizedName.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        self.localizedName.trailingAnchor.constraint(equalTo: rating.leadingAnchor).isActive = true

        self.name.topAnchor.constraint(equalTo: localizedName.bottomAnchor, constant: 6).isActive = true
        self.name.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        self.name.trailingAnchor.constraint(equalTo: rating.leadingAnchor).isActive = true
        self.name.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
}

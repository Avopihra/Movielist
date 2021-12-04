//
//  YearTableViewCell.swift
//  Movielist
//
//  Created by Viktoriya on 03.12.2021.
//

import UIKit

class YearTableViewCell: UITableViewCell {
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - Configure
    func configureFilmCell(with film: Film) {
        self.yearLabel.text = "\(film.year)"
    }
}

extension YearTableViewCell {
    
    private func setConstraints() {
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(yearLabel)
        
        yearLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        yearLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        yearLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
}

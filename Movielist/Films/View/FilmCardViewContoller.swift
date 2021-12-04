//
//  FilmCardViewContoller.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation
import UIKit

class FilmCardViewContoller: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let moviePosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor =  UIColor(named: "movielistBlue")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
//MARK: - Set Constraints
extension FilmCardViewContoller {

}


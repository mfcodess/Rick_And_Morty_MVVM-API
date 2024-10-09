//
//  RickTableViewCell.swift
//  RickAndMorty
//
//  Created by Max on 07.10.2024.
//

import UIKit

final class RickTableViewCell: UITableViewCell {
    
    static let cellId = "RickTableViewCell"
    
    private lazy var rickLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rickImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(rickLabel)
        contentView.addSubview(rickImageView)
        setupViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViewCellUI() {
        NSLayoutConstraint.activate([
            rickLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rickLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            rickImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rickImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rickImageView.leadingAnchor.constraint(equalTo: rickLabel.trailingAnchor, constant: 20),
            rickImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rickImageView.widthAnchor.constraint(equalToConstant: 70),
            rickImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Max on 07.10.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let viewModel = RickViewModel()
    
    //MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RickTableViewCell.self, forCellReuseIdentifier: RickTableViewCell.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        view.addSubview(tableView)
        setupUI()
        fetchData()
    }
    
    //MARK: - Private Methods
    
    private func fetchData() {
        viewModel.fetchCharacter { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - Extension

extension HomeViewController {
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.character == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RickTableViewCell.cellId, for: indexPath) as! RickTableViewCell
        
        if let character = viewModel.character {
            cell.textLabel?.text = character.name
            
            if let imageURL = URL(string: character.image ?? "") {
                
                URLSession.shared.dataTask(with: imageURL) { [weak self] data, responce, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        cell.rickImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

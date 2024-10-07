//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Max on 07.10.2024.
//

import UIKit



class HomeViewController: UIViewController, UITableViewDataSource {
    private var viewModel = RickViewModel()
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
        
        view.backgroundColor = .blue
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(RickTableViewCell.self, forCellReuseIdentifier: "RickCell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    private func fetchData() {
        viewModel.fetchCharacter { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.character == nil ? 0 : 1 // Отображаем одну ячейку, если есть персонаж
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RickCell", for: indexPath) as! RickTableViewCell
        
        if let character = viewModel.character {
            cell.textLabel?.text = character.name
            
            // Загрузка изображения
            if let imageUrl = URL(string: character.image ?? "") {
                // Загрузка изображения асинхронно
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        cell.characterImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
        return cell
    }
}

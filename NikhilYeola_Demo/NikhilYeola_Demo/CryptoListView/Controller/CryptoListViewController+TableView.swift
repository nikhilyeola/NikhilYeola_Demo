//
//  Cr.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 26/11/24.
//

// MARK: - UITableViewDataSource
import UIKit

extension CryptoListViewController: UITableViewDataSource {
    
    // MARK: - TableView
    private func registerTableView(){
        tableView.dataSource = self
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: "CryptoCell")
    }
    
    private func setConstraintsForTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cloudTagView.topAnchor)
        ])
    }
    func setupTableView() {
        view.addSubview(tableView)
        tableView.allowsSelection = false
        registerTableView()
        setConstraintsForTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()
        }

        let coin = viewModel.filteredCoins[indexPath.row]
        cell.configure(cryptoCoin: coin)
        return cell
    }
}

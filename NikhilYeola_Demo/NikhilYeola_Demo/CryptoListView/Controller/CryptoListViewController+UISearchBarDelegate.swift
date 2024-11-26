//
//  CryptoListViewController+UISearchBarDelegate.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 26/11/24.
//

import UIKit

// MARK: - UISearchBarDelegate
extension CryptoListViewController: UISearchBarDelegate {
    func setSearch(){
        searchBar.delegate = self
        searchBar.placeholder = "Search coins"
        searchBar.searchTextField.backgroundColor = .white
    }
    @objc private func closeSearchBar(){
        navigationItem.titleView = nil
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        searchBar.text = ""
        setupNavigationBar()
    }
    @objc func searchButtonTapped() {
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        // Right-Aligned Search Icon
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle"),
            style: .plain,
            target: self,
            action: #selector(closeSearchBar)
        )
        closeButton.tintColor = .white
        navigationItem.rightBarButtonItem = closeButton
        searchBar.becomeFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        viewModel.applyFilter(index: -1, isFromSearch: true, query: searchText)
        viewModel.isErrorOccured = false
        viewModel.errorText = noDataAvailable
        updateUI()
    }
}

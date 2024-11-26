//
//  CryptoListViewController.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 24/11/24.
//

import UIKit

class CryptoListViewController: UIViewController {
    
    // MARK: - Variables declaration
    let tableView = UITableView()
    let searchBar = UISearchBar()
    let cloudTagView = CloudTagView()
    let viewModel = CryptoViewModel()
    var filterTags: [FilterTag]?
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data Available"
        label.textColor = .subTitle
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.isHidden = true // Initially hidden
        return label
    }()
    
    private let reconnectButton : UIButton = {
        let recButton = UIButton(type: .system)
        recButton.setTitle("Reconnect", for: .normal)
        recButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        recButton.addTarget(self, action: #selector(reconnectButtonTapped), for: .touchUpInside)
        return recButton
    }()
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Viewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    // MARK: - SetUI
    private func setupUI() {
        view.backgroundColor = .white
        setupNoDataLabel()
        setupReconnectButton()
        filterTags = viewModel.getFilterTags()
        setupNavigationBar()
        setupCloudTagView()
        setupTableView()
        configureActivityIndicator()
        bindViewModel()
    }
    func updateUI() {
        reconnectButton.isHidden = true
        if viewModel.filteredCoins.isEmpty {
            noDataLabel.text = viewModel.errorText
            noDataLabel.isHidden = false
            tableView.isHidden = true
        } else {
            noDataLabel.isHidden = true
            tableView.isHidden = false
        }
        if viewModel.isErrorOccured{
            viewModel.isErrorOccured = false
//            showMessageAlert(title: "Error", message: viewModel.errorText)
        }
        if viewModel.allCoins.isEmpty && noDataLabel.isHidden == false{
            reconnectButton.isHidden = false
        }
        tableView.reloadData()
    }
    private func configureActivityIndicator(){
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func setupNoDataLabel() {
        view.addSubview(noDataLabel)
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupReconnectButton(){
        view.addSubview(reconnectButton)
        reconnectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reconnectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reconnectButton.topAnchor.constraint(equalTo: noDataLabel.bottomAnchor, constant: 10) // Space between label and button
        ])
    }
    // MARK: - NavigationView & Search
    func setupNavigationBar() {
        // Navigation Bar Appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .navigation
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Left-Aligned Title
        let titleButton = UIButton(type: .custom)
        titleButton.tintColor = .white
        titleButton.setTitle("COIN", for: .normal)
        titleButton.isUserInteractionEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleButton)
        
        // Right-Aligned Search Icon
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = searchButton
        setSearch()
    }
    // MARK: Action
    @objc func reconnectButtonTapped() {
        loadData()
    }
    // MARK: Observer
    func bindViewModel() {
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.updateUI()
                }
            }
        }
    }
    
    // MARK: - Api call
    private func loadData() {
        noDataLabel.isHidden = true
        reconnectButton.isHidden = true
        viewModel.loadCoins { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.updateUI()
            }
        }
    }
    // MARK: - Alert
    private func showMessageAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

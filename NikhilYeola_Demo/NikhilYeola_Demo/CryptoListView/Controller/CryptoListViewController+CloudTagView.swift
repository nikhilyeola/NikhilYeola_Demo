//
//  CryptoListViewController+CloudTagView.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 26/11/24.
//
import UIKit

// MARK: - CloudTagViewDelegate
extension CryptoListViewController: CloudTagViewDelegate {
    // MARK: - CloudTag
    func setupCloudTagView() {
        cloudTagView.delegate = self
        cloudTagView.backgroundColor = .coludTagViewBG
        cloudTagView.configure(with: filterTags!)
        view.addSubview(cloudTagView)
        setConstraintsForCloudTag()
    }
    
    private func setConstraintsForCloudTag(){
        cloudTagView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cloudTagView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cloudTagView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cloudTagView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cloudTagView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func didSelectTag(at index: Int){
        viewModel.applyFilter(index: index, isFromSearch: false)
        viewModel.isErrorOccured = false
        viewModel.errorText = noDataAvailable
        updateUI()
    }
}

//
//  CloudTagView.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 24/11/24.
//

import UIKit

protocol CloudTagViewDelegate: AnyObject {
    func didSelectTag(at index: Int)
}

class CloudTagView: UIView {
    private var tags: [FilterTag] = []
    private let collectionView: UICollectionView
    
    weak var delegate: CloudTagViewDelegate?
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .coludTagViewBG
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with tags: [FilterTag]) {
        self.tags = tags
        collectionView.reloadData()
    }
    
    func updateTag(at index: Int, isSelected: Bool) {
        tags[index].isSelected = isSelected
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
}

extension CloudTagView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: tags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tags[indexPath.item].isSelected.toggle()
        if indexPath.item == 0{
            if tags[1].isSelected == true{
                tags[1].isSelected.toggle()
            }
        }
        if indexPath.item == 1{
            if tags[0].isSelected == true{
                tags[0].isSelected.toggle()
            }
        }
        if indexPath.item == 2{
            if tags[3].isSelected == true{
                tags[3].isSelected.toggle()
            }
        }
        if indexPath.item == 3{
            if tags[2].isSelected == true{
                tags[2].isSelected.toggle()
            }
        }
        delegate?.didSelectTag(at: indexPath.item)
        collectionView.reloadData()
//        collectionView.reloadItems(at: [indexPath])
    }
}

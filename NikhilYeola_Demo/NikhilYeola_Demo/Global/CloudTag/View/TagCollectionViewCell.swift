//
//  TagCollectionViewCell.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 24/11/24.
//


import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TagCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with tag: FilterTag) {
        if tag.isSelected{
            let symbolAttachment = NSTextAttachment()
            symbolAttachment.image = UIImage(systemName: "checkmark") // Use your desired SF Symbol
            symbolAttachment.bounds = CGRect(x: 0, y: -2, width: 15, height: 15) // Adjust bounds as needed
            // Combine the text and symbol
            let finalString = NSMutableAttributedString()
            let symbolString = NSAttributedString(attachment: symbolAttachment)
            finalString.append(symbolString)
            let fullString = NSMutableAttributedString(string: " " + tag.title )
            finalString.append(fullString)
            titleLabel.attributedText = finalString
        }else{
            titleLabel.text = tag.title
        }
        contentView.backgroundColor = tag.isSelected ? .cloudTagCapsuleSelected : .cloudTagCapsuleUnselected
        titleLabel.textColor = .black
    }
}

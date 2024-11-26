//
//  CryptoTableViewCell.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 24/11/24.
//


import UIKit

class CryptoTableViewCell: UITableViewCell {
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .title
        label.numberOfLines = 1
        return label
    }()

    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .subTitle
        label.numberOfLines = 1
        return label
    }()

    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "star.fill") // Placeholder SF Symbol
        imageView.tintColor = .systemYellow
        return imageView
    }()
    private let customNewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "star.fill") // Placeholder SF Symbol
        imageView.tintColor = .systemYellow
        return imageView
    }()
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(customImageView)
        contentView.addSubview(customNewImageView)

        // Disable autoresizing masks for Auto Layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customNewImageView.translatesAutoresizingMaskIntoConstraints = false

        // Setup Auto Layout constraints
        NSLayoutConstraint.activate([
            // Image constraints
            customImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 30),
            customImageView.heightAnchor.constraint(equalToConstant: 30),
 
            // Image constraints
            customNewImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            customNewImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customNewImageView.widthAnchor.constraint(equalToConstant: 30),
            customNewImageView.heightAnchor.constraint(equalToConstant: 30),
            customNewImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),

            // Title label constraints
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: customImageView.leadingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            // Type label constraints
            typeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            typeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
//    imageName: viewModel.getImageName(cryptoCoin: coin),
//    isNew: viewModel.isNewCoin(cryptoCoin: coin)
    // MARK: - Configuration Method
    func configure(cryptoCoin : CryptoCoin){
        titleLabel.text = cryptoCoin.name
        typeLabel.text = cryptoCoin.symbol
        customImageView.image = UIImage(named: cryptoCoin.getImageName())
        if cryptoCoin.isNew{
            customNewImageView.image = UIImage(named: "CryptoNew")
        }else{
            customNewImageView.image = nil
        }
        
        if cryptoCoin.isActive == false{
            titleLabel.textColor = .disableTitle
            typeLabel.textColor = .disableSubTitle
            customImageView.alpha = 0.3
            customNewImageView.alpha = 0.3
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.textColor = .title
        typeLabel.textColor = .subTitle
        customImageView.alpha = 1
        customNewImageView.alpha = 1

    }
}

//
//  CatalogueTableViewCell.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 30.07.2022.
//

import UIKit
import SDWebImage

class CatalogueTableViewCell: UITableViewCell {

    static let reuseIdentifier = "reuseId"
     
    private(set) lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var itemImage: RoundItemImageView = {
        let image = RoundItemImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        allocateFieldsAndButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  
     
    private func allocateFieldsAndButtons() {
        self.backgroundColor = .white

        self.contentView.addSubview(self.itemNameLabel)
        self.contentView.addSubview(self.itemImage)
        self.contentView.addSubview(self.shortDescriptionLabel)
        self.contentView.addSubview(self.priceLabel)

        NSLayoutConstraint.activate([
            self.itemNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.itemNameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.itemNameLabel.widthAnchor.constraint(equalToConstant: 250.0),
            self.itemNameLabel.heightAnchor.constraint(equalToConstant: 100.0),

            self.itemImage.centerYAnchor.constraint(equalTo: self.itemNameLabel.centerYAnchor),

            self.itemImage.leftAnchor.constraint(equalTo: self.itemNameLabel.rightAnchor, constant: 10.0),
            self.itemImage.widthAnchor.constraint(equalToConstant: 80.0),
            self.itemImage.heightAnchor.constraint(equalToConstant: 80.0),
            self.itemImage.centerYAnchor.constraint(equalTo: self.itemNameLabel.centerYAnchor),

            self.shortDescriptionLabel.topAnchor.constraint(equalTo: self.itemNameLabel.bottomAnchor, constant: 10.0),
            self.shortDescriptionLabel.leftAnchor.constraint(equalTo: self.itemNameLabel.leftAnchor),
            self.shortDescriptionLabel.rightAnchor.constraint(equalTo: self.itemImage.rightAnchor),

            self.priceLabel.topAnchor.constraint(equalTo: self.shortDescriptionLabel.bottomAnchor, constant: 10),
            self.priceLabel.leftAnchor.constraint(equalTo: self.shortDescriptionLabel.leftAnchor),
            self.priceLabel.rightAnchor.constraint(equalTo: self.shortDescriptionLabel.rightAnchor),
            self.priceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10.0)
        ])
    }
     
    func configure(_ item: ItemResult) {
        itemNameLabel.text = item.itemName
        shortDescriptionLabel.text = item.shortDescription
        if let itemPrice = item.price {
            priceLabel.text = "$ \(itemPrice.formattedString)"
        } else {
            priceLabel.text = "Out of stock"
        }
        if let picUrl = item.picUrl, let itemUrl = URL(string: picUrl) {
            itemImage.sd_setImage(with: itemUrl)
        } else {
            itemImage.image = UIImage(named: "itemPhotoStub")
        }
    }
}

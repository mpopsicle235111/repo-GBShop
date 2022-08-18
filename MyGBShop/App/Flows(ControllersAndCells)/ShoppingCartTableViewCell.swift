//
//  ShoppingCartTableViewCell.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 18.08.2022.
//

import UIKit

protocol ShoppingCartTableViewCellProtocol: AnyObject {
    func deleteItem(_ index: Int)
}

class ShoppingCartTableViewCell: UITableViewCell {

    static let reuseIdentifier = "reuseId"
    var delegate: ShoppingCartTableViewCellProtocol?
    var row: Int?

     
    private(set) lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .left

        return label
    }()

    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textAlignment = .left

        return label
    }()

    private(set) lazy var picImage: RoundItemImageView = {
        let image = RoundItemImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private(set) lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.bin", withConfiguration: .none), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)

        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .gray
        allocateFieldsAndButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func allocateFieldsAndButtons() {
        self.backgroundColor = .white

        [self.itemNameLabel,
         self.picImage,
         self.priceLabel,
         self.deleteButton
        ].forEach() {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            self.itemNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.itemNameLabel.leadingAnchor.constraint(equalTo: self.picImage.trailingAnchor, constant: 10),
            self.itemNameLabel.widthAnchor.constraint(equalToConstant: 200.0),
            self.itemNameLabel.heightAnchor.constraint(equalToConstant: 100.0),

            self.picImage.centerYAnchor.constraint(equalTo: self.itemNameLabel.centerYAnchor),
            self.picImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10.0),
            self.picImage.widthAnchor.constraint(equalToConstant: 80.0),
            self.picImage.heightAnchor.constraint(equalToConstant: 80.0),
            self.picImage.centerYAnchor.constraint(equalTo: self.itemNameLabel.centerYAnchor),

            self.deleteButton.centerYAnchor.constraint(equalTo: self.itemNameLabel.centerYAnchor),
            self.deleteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.deleteButton.widthAnchor.constraint(equalToConstant: 40.0),
            self.deleteButton.heightAnchor.constraint(equalToConstant: 40.0),

            self.priceLabel.topAnchor.constraint(equalTo: self.itemNameLabel.bottomAnchor, constant: 10),
            self.priceLabel.leftAnchor.constraint(equalTo: self.itemNameLabel.leftAnchor),
            self.priceLabel.rightAnchor.constraint(equalTo: self.itemNameLabel.rightAnchor),
            self.priceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10.0)
        ])
    }
     
    func configure(_ item: AppShoppingCartItem) {
        itemNameLabel.text = item.itemName
        if let itemPrice = item.price {
            priceLabel.text = "\(itemPrice.formattedString) $"
        } else {
            priceLabel.text = "Out of stock"
        }
        if let picUrl = item.picUrl, let itemUrl = URL(string: picUrl) {
            picImage.sd_setImage(with: itemUrl)
        } else {
            picImage.image = UIImage(named: "itemPhotoStub")
        }
    }
     
    @objc private func deleteButtonPressed() {
        delegate?.deleteItem(row ?? 0)
    }


}

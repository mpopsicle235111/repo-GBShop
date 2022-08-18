//
//  ShoppingCartFooterTableViewCell.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 18.08.2022.
//

import UIKit

protocol ShoppingCartFooterTableViewCellProtocol: AnyObject {
    func pressPayButton()
}

class ShoppingCartFooterTableViewCell: UITableViewHeaderFooterView {
    static let reuseIdentifier = "reuseId"
    var delegate: ShoppingCartFooterTableViewCellProtocol?
     
    private(set) lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textAlignment = .center

        return label
    }()


    private(set) lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Checkout", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(payForShoppingCartButtonPressed), for: .touchUpInside)

        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        allocateFieldsAndButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func allocateFieldsAndButtons() {
        self.backgroundColor = .white

        [self.totalLabel,
         self.payButton
        ].forEach() {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            self.totalLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.totalLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.totalLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),

            self.payButton.topAnchor.constraint(equalTo: self.totalLabel.bottomAnchor, constant: 20.0),
            self.payButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.payButton.widthAnchor.constraint(equalToConstant: 250.0),
            self.payButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.payButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10.0)
        ])
    }

     
    func configure() {
        if AppShoppingCart.shared.items.count == 0 {
            self.isHidden = true
        } else {
            self.isHidden = false
        totalLabel.text = "\(AppShoppingCart.shared.items.count) items, \(AppShoppingCart.shared.items.map{ $0.price! }.reduce(0, +).formattedString) $"
    }
    }

     
    @objc private func payForShoppingCartButtonPressed() {
         delegate?.pressPayButton()
    }



}

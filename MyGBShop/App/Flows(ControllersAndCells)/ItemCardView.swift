//
//  ItemCardView.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 05.08.2022.
//

import UIKit

protocol ItemCardViewProtocol: AnyObject {
    func putToCartButtonPressed()
    func pressGetFeedbackButton()
    func pressAddFeedbackButton()
}

class ItemCardView: UIView {
    
    //Inset for fields
    let inset = 30.0

    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 700)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = false


        return scrollView
    }()

    private(set) lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var picImage: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private(set) lazy var putToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemOrange
        button.setTitle("Put to cart", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(toCartButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private(set) lazy var feedbackLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "Customer feedback"
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var getFeedbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Read customer feedback", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(getFeedbackButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private(set) lazy var addFeedbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Comment", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(addFeedbackButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    weak var delegate: ItemCardViewProtocol?
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func configureUI() {
        self.backgroundColor = .white
        self.addSubview(self.scrollView)
        [self.itemNameLabel,
         self.priceLabel,
         self.picImage,
         self.descriptionLabel,
         self.putToCartButton,
         self.feedbackLabel,
         self.getFeedbackButton,
         self.addFeedbackButton
        ].forEach() {
            self.scrollView.addSubview($0)
        }

        NSLayoutConstraint.activate([

            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
            self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),

            self.itemNameLabel.topAnchor.constraint(lessThanOrEqualTo: self.scrollView.topAnchor, constant: 10),
            self.itemNameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            self.itemNameLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10),

            self.picImage.topAnchor.constraint(equalTo: self.itemNameLabel.bottomAnchor, constant: 10.0),
            self.picImage.heightAnchor.constraint(equalToConstant: 300.0),
            self.picImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
            self.picImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

            self.descriptionLabel.topAnchor.constraint(equalTo: self.picImage.bottomAnchor, constant: 10),
            self.descriptionLabel.leftAnchor.constraint(equalTo: itemNameLabel.leftAnchor),
            self.descriptionLabel.rightAnchor.constraint(equalTo: itemNameLabel.rightAnchor),

            self.priceLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20),
            self.priceLabel.leftAnchor.constraint(equalTo: itemNameLabel.leftAnchor),
            self.priceLabel.rightAnchor.constraint(equalTo: itemNameLabel.rightAnchor),

            self.putToCartButton.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 20.0),
            self.putToCartButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.putToCartButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
            self.putToCartButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

            self.feedbackLabel.topAnchor.constraint(equalTo: self.putToCartButton.bottomAnchor, constant: 20),
            self.feedbackLabel.leftAnchor.constraint(equalTo: itemNameLabel.leftAnchor),
            self.feedbackLabel.rightAnchor.constraint(equalTo: itemNameLabel.rightAnchor),

            self.getFeedbackButton.topAnchor.constraint(equalTo: self.feedbackLabel.bottomAnchor, constant: 20.0),
            self.getFeedbackButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.getFeedbackButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
            self.getFeedbackButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

            self.addFeedbackButton.topAnchor.constraint(equalTo: self.getFeedbackButton.bottomAnchor, constant: 20.0),
            self.addFeedbackButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.addFeedbackButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
            self.addFeedbackButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
        ])
    }

     
    func configure(_ item: ItemByIdResult) {
        itemNameLabel.text = item.itemName ?? ""
        descriptionLabel.text = item.description ?? ""
        if let itemPrice = item.price {
            priceLabel.text = "\(itemPrice.formattedString) USD"
        } else {
            priceLabel.text = "Item not available"
        }
        if let picUrl = item.picUrl, let itemUrl = URL(string: picUrl) {
            picImage.sd_setImage(with: itemUrl)
        } else {
            picImage.image = UIImage(named: "itemPhotoStub")
        }
    }
     
    @objc private func toCartButtonPressed() {
        delegate?.putToCartButtonPressed()
    }

    @objc private func getFeedbackButtonPressed() {
        delegate?.pressGetFeedbackButton()
    }

    @objc private func addFeedbackButtonPressed() {
        delegate?.pressAddFeedbackButton()
    }

}

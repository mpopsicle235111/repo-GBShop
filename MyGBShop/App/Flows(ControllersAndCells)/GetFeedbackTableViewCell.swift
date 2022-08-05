//
//  GetFeedbackTableViewCell.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 05.08.2022.
//

import UIKit

class GetFeedbackTableViewCell: UITableViewCell {

    static let reuseIdentifier = "reuseIdentifier"
     
    private(set) lazy var userIdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var feedbackTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        allocateFieldsAndButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func allocateFieldsAndButtons() {
        self.backgroundColor = .white
        [self.feedbackTextLabel, self.userIdLabel].forEach() {
            self.contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            self.userIdLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.userIdLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            self.userIdLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),

            self.feedbackTextLabel.topAnchor.constraint(equalTo: self.userIdLabel.bottomAnchor, constant: 15),
            self.feedbackTextLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            self.feedbackTextLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.feedbackTextLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)

        ])
    }
     
    func configure(_ item: FeedbackResult) {
        feedbackTextLabel.text = item.feedbackText ?? ""
        userIdLabel.text = "Feedback from customer Nr. \(String(describing: item.userId ?? 0) )"
    }

}

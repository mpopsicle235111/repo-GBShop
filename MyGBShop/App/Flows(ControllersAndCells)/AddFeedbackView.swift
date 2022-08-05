//
//  AddFeedbackView.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 05.08.2022.
//

import UIKit

protocol AddFeedbackViewProtocol: AnyObject {
    func pressSaveFeedbackButton(feedbackResult: FeedbackResult)
}

class AddFeedbackView: UIView {
    
    //Inset for fields
    let inset = 30.0

    private(set) lazy var feedbackField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.attributedPlaceholder = NSAttributedString(string: "Please leave feeedback", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private(set) lazy var saveFeedbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Save", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(saveFeedbackButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    weak var delegate: AddFeedbackViewProtocol?

    private var ItemId = 0
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.allocateFieldsAndButtons()
        self.setupControls()
        self.registerNotifications()
        self.hideKeyboardGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func allocateFieldsAndButtons() {
        self.backgroundColor = .white
        [self.feedbackField, self.saveFeedbackButton].forEach() {
            self.addSubview($0)
        }

        NSLayoutConstraint.activate([

            self.feedbackField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            self.feedbackField.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 10.0),
            self.feedbackField.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: -10.0),
            self.feedbackField.heightAnchor.constraint(equalToConstant: 200.0),

            self.saveFeedbackButton.topAnchor.constraint(equalTo: self.feedbackField.bottomAnchor, constant: 20.0),
            self.saveFeedbackButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.saveFeedbackButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
            self.saveFeedbackButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),

        ])
    }

    func config(ItemId: Int) {
        self.ItemId = ItemId
    }
     
    private func setupControls() {
        saveFeedbackButton.backgroundColor = UIColor.opaqueSeparator
        saveFeedbackButton.isEnabled = false

        [feedbackField].forEach {
            $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
    }

    private func checkfeedbackInput() -> Bool {
        guard feedbackField.text != "" else {
            return false
        }
        return true
    }

    private func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                                name: UIResponder.keyboardWillShowNotification,
                                                object: nil)

        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillHide),
                                                name: UIResponder.keyboardWillHideNotification,
                                                object: nil)
    }

    private func hideKeyboardGesture() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))

        self.addGestureRecognizer(hideKeyboardGesture)
    }
     
    @objc private func saveFeedbackButtonPressed() {

        delegate?.pressSaveFeedbackButton(feedbackResult: FeedbackResult(userId: 123, feedbackText: feedbackField.text ?? "", productIdNumber: ItemId))

    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.convert(keyboardFrame, from: nil)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let _: UIEdgeInsets = UIEdgeInsets.zero
    }

    @objc func hideKeyboard() {
        self.endEditing(true)
    }

    @objc func editingChanged(_ textField: UITextField) {
        guard checkfeedbackInput() else {
            saveFeedbackButton.backgroundColor = UIColor.opaqueSeparator
            saveFeedbackButton.isEnabled = false
            return
        }
        saveFeedbackButton.backgroundColor = .white
        saveFeedbackButton.isEnabled = true
    }

}

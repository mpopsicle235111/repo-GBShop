//
//  GetUserDataView.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 27.07.2022.
//

import UIKit

protocol GetUserDataViewProtocol: AnyObject {
     func pressSaveButton(user: User)
     func pressLogoutButton()
}

class GetUserDataView: UIView {
    
     //Inset for input fields
     let inset = 30.0

     // MARK: - Subviews
     private(set) lazy var scrollView: UIScrollView = {
         let scrollView = UIScrollView(frame: .zero)
         scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1100)
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         scrollView.isPagingEnabled = false

         return scrollView
     }()

     private(set) lazy var headerLabel: UILabel = {
         let label = UILabel()
         label.text = "Your Preferences"
         label.numberOfLines = 2
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 20.0)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()

     private(set) lazy var loginLabel: UILabel = {
         let label = UILabel()
         label.text = "Login:"
         label.numberOfLines = 1
         label.textColor = .systemGray
         label.font = UIFont.systemFont(ofSize: 16.0)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()

     private(set) lazy var loginTextField: UITextField = {
         let textField = UITextField()
         textField.borderStyle = .bezel
         textField.attributedPlaceholder = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         textField.textColor = .black
         textField.translatesAutoresizingMaskIntoConstraints = false

         return textField
     }()

     private(set) lazy var passwordLabel: UILabel = {
         let label = UILabel()
         label.text = "Password:"
         label.numberOfLines = 1
         label.textColor = .systemGray
         label.font = UIFont.systemFont(ofSize: 16.0)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()

     private(set) lazy var passwordTextField: UITextField = {
         let textField = UITextField()
         textField.borderStyle = .bezel
         textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         textField.textColor = .black
         textField.translatesAutoresizingMaskIntoConstraints = false

         return textField
     }()

     private(set) lazy var firstNameLabel: UILabel = {
         let label = UILabel()
         label.text = "Name:"
         label.numberOfLines = 1
         label.textColor = .systemGray
         label.font = UIFont.systemFont(ofSize: 16.0)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()

     private(set) lazy var firstNameTextField: UITextField = {
         let textField = UITextField()
         textField.borderStyle = .bezel
         textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         textField.textColor = .black
         textField.translatesAutoresizingMaskIntoConstraints = false

         return textField
     }()

     private(set) lazy var lastNameLabel: UILabel = {
         let label = UILabel()
         label.text = "Last name:"
         label.numberOfLines = 1
         label.textColor = .systemGray
         label.font = UIFont.systemFont(ofSize: 16.0)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()

     private(set) lazy var lastNameTextField: UITextField = {
         let textField = UITextField()
         textField.borderStyle = .bezel
         textField.attributedPlaceholder = NSAttributedString(string: "Last name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         textField.textColor = .black
         textField.translatesAutoresizingMaskIntoConstraints = false

         return textField
     }()

     private(set) lazy var emailLabel: UILabel = {
         let label = UILabel()
         label.text = "E-mail:"
         label.numberOfLines = 1
         label.textColor = .systemGray
         label.font = UIFont.systemFont(ofSize: 16.0)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()

     private(set) lazy var emailTextField: UITextField = {
         let textField = UITextField()
         textField.borderStyle = .bezel
         textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         textField.textColor = .black
         textField.translatesAutoresizingMaskIntoConstraints = false

         return textField
     }()
     
     //MARK: for foreign market this has to be modified
     private(set) lazy var genderSegmentedControl: UISegmentedControl = {
         let items = ["👔","👗"]
         let segmentControl = UISegmentedControl(items: items)
         segmentControl.selectedSegmentIndex = 0
         segmentControl.backgroundColor = .gray
         segmentControl.selectedSegmentTintColor = .orange
         segmentControl.translatesAutoresizingMaskIntoConstraints = false
         segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], for: .selected)
         segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)], for: .normal)

         return segmentControl
     }()

     private(set) lazy var creditCardLabel: UILabel = {
         let label = UILabel()
         label.text = "Credit Card Number:"
         label.numberOfLines = 1
         label.textColor = .systemGray
         label.font = UIFont.systemFont(ofSize: 16.0)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()

     private(set) lazy var creditCardTextField: UITextField = {
         let textField = UITextField()
         textField.borderStyle = .bezel
         textField.attributedPlaceholder = NSAttributedString(string: "Creadit Card", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         textField.textColor = .black
         textField.translatesAutoresizingMaskIntoConstraints = false

         return textField
     }()

     private(set) lazy var tagLineLabel: UILabel = {
         let label = UILabel()
         label.text = "The motto of your life:"
         label.numberOfLines = 1
         label.textColor = .systemGray
         label.font = UIFont.systemFont(ofSize: 16.0)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()

     private(set) lazy var tagLineTextField: UITextField = {
         let textField = UITextField()
         textField.borderStyle = .bezel
         textField.attributedPlaceholder = NSAttributedString(string: "The motto of my life", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         textField.textColor = .black
         textField.translatesAutoresizingMaskIntoConstraints = false

         return textField
     }()

     private(set) lazy var saveButton: UIButton = {
         let button = UIButton()
         button.backgroundColor = .blue
         button.setTitle("Save", for: .normal)
         button.clipsToBounds = true
         button.layer.cornerRadius = 10.0
         button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
         button.translatesAutoresizingMaskIntoConstraints = false

         return button
     }()

     private(set) lazy var logoutButton: UIButton = {
         let button = UIButton()
         button.backgroundColor = .red
         button.tintColor = .white
         button.layer.cornerRadius = 10.0
         button.setTitle("Log Out", for: .normal)
         button.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
         button.translatesAutoresizingMaskIntoConstraints = false

         return button
     }()

     weak var delegate: GetUserDataViewProtocol?
     
     func config(user: User) {
         loginTextField.text = user.login
         passwordTextField.text = user.password
         firstNameTextField.text = user.firstName
         lastNameTextField.text = user.lastName
         emailTextField.text = user.email
         creditCardTextField.text = user.creditCardNumber
         tagLineTextField.text = user.tagLine

         switch user.gender {
         case "👔":
             genderSegmentedControl.selectedSegmentIndex = Int(0)
         case "👗":
             genderSegmentedControl.selectedSegmentIndex = Int(1)
         default:
             genderSegmentedControl.selectedSegmentIndex = Int(0)
         }
     }

     
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

     // MARK: - UI
     
     private func allocateFieldsAndButtons() {
         self.backgroundColor = .white
         self.addSubview(self.scrollView)
         self.scrollView.addSubview(self.headerLabel)
         self.scrollView.addSubview(self.loginLabel)
         self.scrollView.addSubview(self.loginTextField)
         self.scrollView.addSubview(self.passwordLabel)
         self.scrollView.addSubview(self.passwordTextField)
         self.scrollView.addSubview(self.firstNameLabel)
         self.scrollView.addSubview(self.firstNameTextField)
         self.scrollView.addSubview(self.lastNameLabel)
         self.scrollView.addSubview(self.lastNameTextField)
         self.scrollView.addSubview(self.emailLabel)
         self.scrollView.addSubview(self.emailTextField)
         self.scrollView.addSubview(self.genderSegmentedControl)
         self.scrollView.addSubview(self.creditCardLabel)
         self.scrollView.addSubview(self.creditCardTextField)
         self.scrollView.addSubview(self.tagLineLabel)
         self.scrollView.addSubview(self.tagLineTextField)
         self.scrollView.addSubview(self.saveButton)
         self.scrollView.addSubview(self.logoutButton)

         NSLayoutConstraint.activate([
             self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
             self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
             self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
             self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),

             self.headerLabel.topAnchor.constraint(lessThanOrEqualTo: self.scrollView.topAnchor, constant: 20),
             self.headerLabel.heightAnchor.constraint(equalToConstant: 50.0),
             self.headerLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.headerLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.loginLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 10.0),
             self.loginLabel.heightAnchor.constraint(equalToConstant: 20.0),
             self.loginLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.loginLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.loginTextField.topAnchor.constraint(equalTo: self.loginLabel.bottomAnchor, constant: 8.0),
             self.loginTextField.heightAnchor.constraint(equalToConstant: 50.0),
             self.loginTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.loginTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.passwordLabel.topAnchor.constraint(equalTo: self.loginTextField.bottomAnchor, constant: 10.0),
             self.passwordLabel.heightAnchor.constraint(equalToConstant: 20.0),
             self.passwordLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.passwordLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.passwordTextField.topAnchor.constraint(equalTo: self.passwordLabel.bottomAnchor, constant: 8.0),
             self.passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
             self.passwordTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.passwordTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),


             self.firstNameLabel.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 10.0),
             self.firstNameLabel.heightAnchor.constraint(equalToConstant: 20.0),
             self.firstNameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.firstNameLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.firstNameTextField.topAnchor.constraint(equalTo: self.firstNameLabel.bottomAnchor, constant: 8.0),
             self.firstNameTextField.heightAnchor.constraint(equalToConstant: 50.0),
             self.firstNameTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.firstNameTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.lastNameLabel.topAnchor.constraint(equalTo: self.firstNameTextField.bottomAnchor, constant: 10.0),
             self.lastNameLabel.heightAnchor.constraint(equalToConstant: 20.0),
             self.lastNameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.lastNameLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.lastNameTextField.topAnchor.constraint(equalTo: self.lastNameLabel.bottomAnchor, constant: 8.0),
             self.lastNameTextField.heightAnchor.constraint(equalToConstant: 50.0),
             self.lastNameTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.lastNameTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.emailLabel.topAnchor.constraint(equalTo: self.lastNameTextField.bottomAnchor, constant: 8.0),
             self.emailLabel.heightAnchor.constraint(equalToConstant: 20.0),
             self.emailLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.emailLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.emailTextField.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 8.0),
             self.emailTextField.heightAnchor.constraint(equalToConstant: 50.0),
             self.emailTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.emailTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.genderSegmentedControl.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10.0),
             self.genderSegmentedControl.heightAnchor.constraint(equalToConstant: 50.0),
             self.genderSegmentedControl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.genderSegmentedControl.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.creditCardLabel.topAnchor.constraint(equalTo: self.genderSegmentedControl.bottomAnchor, constant: 10.0),
             self.creditCardLabel.heightAnchor.constraint(equalToConstant: 20.0),
             self.creditCardLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.creditCardLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.creditCardTextField.topAnchor.constraint(equalTo: self.creditCardLabel.bottomAnchor, constant: 8.0),
             self.creditCardTextField.heightAnchor.constraint(equalToConstant: 50.0),
             self.creditCardTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.creditCardTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.tagLineLabel.topAnchor.constraint(equalTo: self.creditCardTextField.bottomAnchor, constant: 10.0),
             self.tagLineLabel.heightAnchor.constraint(equalToConstant: 20.0),
             self.tagLineLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.tagLineLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.tagLineTextField.topAnchor.constraint(equalTo: self.tagLineLabel.bottomAnchor, constant: 8.0),
             self.tagLineTextField.heightAnchor.constraint(equalToConstant: 50.0),
             self.tagLineTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.tagLineTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.saveButton.topAnchor.constraint(equalTo: self.tagLineTextField.bottomAnchor, constant: 30.0),
             self.saveButton.heightAnchor.constraint(equalToConstant: 50.0),
             self.saveButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.saveButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

             self.logoutButton.topAnchor.constraint(equalTo: self.saveButton.bottomAnchor, constant: 20.0),
             self.logoutButton.heightAnchor.constraint(equalToConstant: 50.0),
             self.logoutButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
             self.logoutButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

         ])

     }
     
     private func setupControls() {
         saveButton.backgroundColor = UIColor.opaqueSeparator
         saveButton.isEnabled = false

         [loginTextField, passwordTextField, firstNameTextField, lastNameTextField, emailTextField, creditCardTextField, tagLineTextField].forEach {
             $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
         }
     }

     private func checkLoginInput() -> Bool {
         guard firstNameTextField.text != "",
               lastNameTextField.text != "",
               emailTextField.text != "",
               loginTextField.text != "",
               passwordTextField.text != "" else {
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

         scrollView.addGestureRecognizer(hideKeyboardGesture)
     }
     
     @objc private func saveButtonPressed() {
         let user = User(login: loginTextField.text ?? "",
                         firstName: firstNameTextField.text ?? "",
                         lastName: lastNameTextField.text ?? "", password: passwordTextField.text ?? "",
                         email: emailTextField.text ?? "",
                         gender:  genderSegmentedControl.selectedSegmentIndex == 0 ? "m" : "f",
                         creditCardNumber: creditCardTextField.text ?? "",
                         tagLine: tagLineTextField.text ?? "")

         delegate?.pressSaveButton(user: user)

     }

     @objc private func logoutButtonPressed() {
         delegate?.pressLogoutButton()
     }

     @objc func keyboardWillShow(notification: NSNotification) {
         guard let userInfo = notification.userInfo else { return }

         var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
         var contentInset: UIEdgeInsets = self.scrollView.contentInset

         keyboardFrame = self.scrollView.convert(keyboardFrame, from: nil)

         contentInset.bottom = keyboardFrame.size.height + 50
         scrollView.contentInset = contentInset
     }

     @objc func keyboardWillHide(notification: NSNotification) {
         let contentInset: UIEdgeInsets = UIEdgeInsets.zero
         scrollView.contentInset = contentInset
     }

     @objc func hideKeyboard() {
         self.scrollView.endEditing(true)
     }

     @objc func editingChanged(_ textField: UITextField) {
         guard checkLoginInput() else {
             saveButton.backgroundColor = UIColor.opaqueSeparator
             saveButton.isEnabled = false
             return
         }
         saveButton.backgroundColor = .orange
         saveButton.isEnabled = true
     }

 }

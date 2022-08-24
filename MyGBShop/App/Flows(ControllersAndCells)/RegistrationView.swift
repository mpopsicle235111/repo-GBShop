//
//  RegistrationView.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 27.07.2022.
//

import UIKit
import FirebaseCrashlytics

protocol RegistrationViewProtocol: AnyObject {
     func pressRegisterButton(user: User)

}

class RegistrationView: UIView {

    //Inset for input fields
    let inset = 30.0

    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 700)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = false

        return scrollView
    }()

    private(set) lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "User Registration"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
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

    private(set) lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Family Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private(set) lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private(set) lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    //MARK: for foreign market this has to be modified 
    private(set) lazy var genderSegmentedControl: UISegmentedControl = {
        let items = ["👔","👗"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .lightGray
        segmentControl.selectedSegmentTintColor = .orange
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], for: .selected)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)], for: .normal)

        return segmentControl
    }()

    private(set) lazy var tagLineTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Motto (optional)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private(set) lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Register", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private(set) lazy var resetAllButtons: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.tintColor = .white
        button.layer.cornerRadius = 10.0
        button.setTitle("Reset Form", for: .normal)
        button.addTarget(self, action: #selector(resetAllButtonsPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()


    weak var delegate: RegistrationViewProtocol?
     
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
        self.addSubview(self.scrollView)
        [self.headerLabel,
         self.firstNameTextField,
         self.lastNameTextField,
         self.loginTextField,
         self.passwordTextField,
         self.emailTextField,
         self.genderSegmentedControl,
         self.tagLineTextField,
         self.registerButton,
         self.resetAllButtons
        ].forEach {
            self.scrollView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
        self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
        self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
        self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),

        self.headerLabel.topAnchor.constraint(lessThanOrEqualTo: self.scrollView.topAnchor, constant: 20),
        self.headerLabel.heightAnchor.constraint(equalToConstant: 30.0),
        self.headerLabel.widthAnchor.constraint(equalToConstant: 400.0),
        self.headerLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

        self.firstNameTextField.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 10.0),
        self.firstNameTextField.heightAnchor.constraint(equalToConstant: 50.0),
        self.firstNameTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
        self.firstNameTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

        self.lastNameTextField.topAnchor.constraint(equalTo: self.firstNameTextField.bottomAnchor, constant: 10.0),
        self.lastNameTextField.heightAnchor.constraint(equalToConstant: 50.0),
        self.lastNameTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
        self.lastNameTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

        self.loginTextField.topAnchor.constraint(equalTo: self.lastNameTextField.bottomAnchor, constant: 10.0),
        self.loginTextField.heightAnchor.constraint(equalToConstant: 50.0),
        self.loginTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
        self.loginTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

        self.emailTextField.topAnchor.constraint(equalTo: self.loginTextField.bottomAnchor, constant: 10.0),
        self.emailTextField.heightAnchor.constraint(equalToConstant: 50.0),
        self.emailTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
        self.emailTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

        self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10.0),
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
        self.passwordTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
        self.passwordTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

        self.genderSegmentedControl.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 10.0),
        self.genderSegmentedControl.heightAnchor.constraint(equalToConstant: 50.0),
        self.genderSegmentedControl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
        self.genderSegmentedControl.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

        self.tagLineTextField.topAnchor.constraint(equalTo: self.genderSegmentedControl.bottomAnchor, constant: 10.0),
        self.tagLineTextField.heightAnchor.constraint(equalToConstant: 50.0),
        self.tagLineTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
        self.tagLineTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

        self.registerButton.topAnchor.constraint(equalTo: self.tagLineTextField.bottomAnchor, constant: 30.0),
        self.registerButton.heightAnchor.constraint(equalToConstant: 50.0),
        self.registerButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
        self.registerButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

        self.resetAllButtons.topAnchor.constraint(equalTo: self.registerButton.bottomAnchor, constant: 20.0),
        self.resetAllButtons.heightAnchor.constraint(equalToConstant: 50.0),
        self.resetAllButtons.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
        self.resetAllButtons.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
        ])

    }
     
    private func setupControls() {
        registerButton.backgroundColor = UIColor.opaqueSeparator
        registerButton.isEnabled = false

        [firstNameTextField, lastNameTextField, emailTextField, loginTextField, passwordTextField, tagLineTextField].forEach {
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
     
    @objc private func registerButtonPressed() {
        let user = User(login: loginTextField.text ?? "",
                        firstName: firstNameTextField.text ?? "",
                        lastName: lastNameTextField.text ?? "",
                        password: passwordTextField.text ?? "",
                        email: emailTextField.text ?? "",
                        gender: genderSegmentedControl.selectedSegmentIndex == 0 ? "m" : "f",
                        tagLine: tagLineTextField.text ?? "")

        delegate?.pressRegisterButton(user: user)

    }

    @objc private func resetAllButtonsPressed() {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        loginTextField.text = ""
        passwordTextField.text = ""
        tagLineTextField.text = ""
        genderSegmentedControl.selectedSegmentIndex = 0

        setupControls()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        //This was before:
        //guard let userInfo = notification.userInfo else { return }
        //Now with Crashlytics:
        guard let userInfo = notification.userInfo else { Crashlytics.crashlytics().log("thereIsNoInformationAboutThisUser")
            return
        }

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
            registerButton.backgroundColor = UIColor.opaqueSeparator
            registerButton.isEnabled = false
            return
        }
        registerButton.backgroundColor = .orange
        registerButton.isEnabled = true
    }

}

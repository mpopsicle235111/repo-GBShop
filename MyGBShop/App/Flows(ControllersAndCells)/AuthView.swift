//
//  AuthView.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 26.07.2022.
//

import UIKit

protocol AuthViewProtocol: AnyObject {
    func pressLoginButton(userName: String, password: String)
    func pressRegisterButton()

}

class AuthView: UIView {
    
    //Inset for input fields
    let inset = 30.0

    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 600)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = false


        return scrollView
    }()

    private(set) lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.attributedPlaceholder = NSAttributedString(string: "Login: Jack007", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.font = UIFont(name: "Helvetica", size: 22)
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont(name: "Helvetica", size: 22)
        textField.attributedPlaceholder = NSAttributedString(string: "Password: sourCream2!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.borderStyle = .line
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private(set) lazy var loginButton: UIButton = {
        let button = UIButton()
        //This makes button text font too small:
        //let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Log In", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private(set) lazy var registerButton: UIButton = {
        let button = UIButton()
        //This makes button text font too small:
        //let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.tintColor = .white
        button.layer.cornerRadius = 10.0
        button.setTitle("Register a new user", for: .normal)
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private(set) lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Powered by Heroku"
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    weak var delegate: AuthViewProtocol?
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.allocateFieldsAndButtons()
        self.setupControls()
        self.registerNotifications()
        self.hideKeyboardGesture()
        self.setupAccessibility()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func allocateFieldsAndButtons() {
        self.backgroundColor = .white
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.loginTextField)
        self.scrollView.addSubview(self.passwordTextField)
        self.scrollView.addSubview(self.loginButton)
        self.scrollView.addSubview(self.registerButton)
        self.scrollView.addSubview(self.infoLabel)
        
        NSLayoutConstraint.activate([

            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
            self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),

            self.loginTextField.topAnchor.constraint(lessThanOrEqualTo: self.scrollView.topAnchor, constant: 50),
            self.loginTextField.heightAnchor.constraint(equalToConstant: 50.0),
            self.loginTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
            self.loginTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

            self.passwordTextField.topAnchor.constraint(equalTo: self.loginTextField.bottomAnchor, constant: 20.0),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
            self.passwordTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 2),
            self.passwordTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 30.0),
            self.loginButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.loginButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 4),
            self.loginButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),

            self.registerButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 20.0),
            self.registerButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.registerButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset * 4),
            self.registerButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
             
            self.infoLabel.topAnchor.constraint(equalTo: self.registerButton.bottomAnchor, constant: 50.0),
            self.infoLabel.heightAnchor.constraint(equalToConstant: 200.0),
            self.infoLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - inset),
            self.infoLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
        ])
    }

     
    private func setupControls() {
        loginButton.backgroundColor = UIColor.opaqueSeparator
        loginButton.isEnabled = false

        [loginTextField, passwordTextField].forEach {
             $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
    }

    private func checkLoginInput() -> Bool {
        guard loginTextField.text != "",
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
    
    private func setupAccessibility() {
        
        self.accessibilityIdentifier = "loginView"
        self.loginTextField.accessibilityIdentifier = "loginTextField"
        self.passwordTextField.accessibilityIdentifier = "passwordTextField"
        self.loginButton.accessibilityIdentifier = "loginButton"
        self.registerButton.accessibilityIdentifier = "registerButton"
    }
   
     
    @objc private func loginButtonPressed() {
        let userName = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        delegate?.pressLoginButton(userName: userName, password: password)
        loginTextField.text = ""
        passwordTextField.text = ""

     }

     @objc private func registerButtonPressed() {
         delegate?.pressRegisterButton()
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
             loginButton.backgroundColor = UIColor.opaqueSeparator
             loginButton.isEnabled = false
             return
         }
         loginButton.backgroundColor = .orange
         loginButton.isEnabled = true
     }
}

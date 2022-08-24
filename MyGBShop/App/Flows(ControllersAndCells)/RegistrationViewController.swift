//
//  RegistrationViewController.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 27.07.2022.
//

import UIKit

 class RegistrationViewController: UIViewController {

     private var authView: RegistrationView {
         return self.view as! RegistrationView
     }

     let requestFactory = RequestFactory()
     
     override func loadView() {
         super.loadView()
         let view = RegistrationView()
         view.delegate = self
         self.view = view
     }

     override func viewDidLoad() {
         super.viewDidLoad()
         //Added for testing
         view.accessibilityIdentifier = "registrationViewController"
     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(false, animated: true)
         navigationController?.navigationBar.isTranslucent = true
         navigationController?.navigationItem.hidesBackButton = false
     }
     
     
     
     private func displayErrorMessage(_ errorMessage: String) {
         let alert = UIAlertController(title: "ERROR",
                                       message: errorMessage,
                                       preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "ОK",
                                       style: .default,
                                       handler: nil))
         present(alert, animated: true, completion: nil)
     }

     private func goToMainScreen() {
         let alert = UIAlertController(title: "SignUp Success." ,
                                       message: "Enter the app with your login and password",
                                       preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "ОK",
                                       style: .default,
                                       handler: { _ in
             self.navigationController?.popViewController(animated: true)
         }))
         present(alert, animated: true, completion: nil)
     }

 }

 extension RegistrationViewController: RegistrationViewProtocol {
     func pressRegisterButton(user: User) {
         let register = requestFactory.makeRegistRequestFactory()

         register.register(user: user) { [weak self] response in
             DispatchQueue.main.async {
                 switch response.result {
                 case .success(let result):
                     result.result == 1 ? self?.goToMainScreen() : self?.displayErrorMessage(result.errorMessage ?? "Unknown Error")
                     print(result)
                 case .failure(let error):
                     self?.displayErrorMessage(error.localizedDescription)
                     print(error.localizedDescription)
                 }
             }
         }
     }
 }

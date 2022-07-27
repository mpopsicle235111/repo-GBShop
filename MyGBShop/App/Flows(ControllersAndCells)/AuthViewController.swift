//
//  AuthViewController.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 26.07.2022.
//

import UIKit

class AuthViewController: UIViewController {

    private var authView: AuthView {
        return self.view as! AuthView
    }

    let requestFactory = RequestFactory()

     
    override func loadView() {
        super.loadView()
        let view = AuthView()
        view.delegate = self
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

     
    private func displayErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Authorization Error!",
                                       message: errorMessage,
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОK",
                                       style: .default,
                                       handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func goToMainScreen() {
        navigationController?.pushViewController(TabBarViewController(), animated: true)
    }

}


extension AuthViewController: AuthViewProtocol {

    func pressLoginButton(userName: String, password: String) {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(userName: userName, password: password) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let result):
                    result.result == 1 ? self.goToMainScreen() : self.displayErrorMessage(result.errorMessage ?? "Undefined Error!")
                    print(result)
                case .failure(let error):
                    self.displayErrorMessage(error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
        }
    }

    func pressRegisterButton() {
         navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
}

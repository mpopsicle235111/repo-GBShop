//
//  GetUserDataViewController.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 27.07.2022.
//

import UIKit

class GetUserDataViewController: UIViewController {

    let user = User(id: 001,
                    login: "Jack007",
                    firstName: "Jack",
                    lastName: "Abramoff",
                    password: "sourCream2!",
                    email: "jackabramoff@aol.com",
                    gender: "m",
                    creditCardNumber: "1234567812345678",
                    tagLine: "Money rule the world!"
                    )



    private var authView: GetUserDataView {
        return self.view as! GetUserDataView
    }

    let requestFactory = RequestFactory()

    override func loadView() {
        super.loadView()
        navigationController?.isNavigationBarHidden = true
        let view = GetUserDataView()
        view.config(user: user)
        view.delegate = self
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
     
    private func displayErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "ERROR",
                                      message: errorMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func confirmToSaveUserData(user: User) {
        let alert = UIAlertController(title: "",
                                      message: "Save changes?",
                                      preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes",
                                      style: .cancel,
                                      handler: {action in
            let changeUserData = self.requestFactory.makeСhangeUserDataFactory()

            changeUserData.changeUserData(user: user) {response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let result):
                        result.result == 1 ? self.savePopUpConfirmation() : self.displayErrorMessage(result.errorMessage ?? "Unknown Error")
                        print(result)
                    case .failure(let error):
                        self.displayErrorMessage(error.localizedDescription)
                        print(error.localizedDescription)
                    }
                }
            }
            self.dismiss(animated: true, completion: nil)})

        let actionNo = UIAlertAction(title: "NO",
                                     style: .default,
                                     handler: { _ in self.loadView()})
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        self.present(alert, animated: true,completion: nil)
    }

    private func savePopUpConfirmation() {
        let alert = UIAlertController(title: "All OK" ,
                                      message: "Your new data saved",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func confirmToLogOut(user: User) {
        let alert = UIAlertController(title: "",
                                      message: "Quit? R U Sure?",
                                      preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "YEPH",
                                      style: .cancel,
                                      handler: {action in
            let auth = self.requestFactory.makeAuthRequestFactory()
             auth.logout(userID: user.id ?? 0) { response in
                 DispatchQueue.main.async {
                     switch response.result {
                     case .success(let result):
                         result.result == 1 ? self.logOut() : self.displayErrorMessage(result.errorMessage ?? "Unknown Error")
                         print(result)
                     case .failure(let error):
                         self.displayErrorMessage(error.localizedDescription)
                         print(error.localizedDescription)
                     }
                }
            }
            self.dismiss(animated: true, completion: nil)})

        let actionNo = UIAlertAction(title: "NOPE",
                                     style: .default,
                                     handler: nil)
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        self.present(alert, animated: true,completion: nil)
    }

    private func logOut() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension GetUserDataViewController: GetUserDataViewProtocol {
    func pressSaveButton(user: User) {
        self.confirmToSaveUserData(user: user)
    }

    func pressLogoutButton() {
        self.confirmToLogOut(user: self.user)
    }
}

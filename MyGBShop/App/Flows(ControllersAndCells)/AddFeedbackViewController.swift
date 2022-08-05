//
//  AddFeedbackViewController.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 05.08.2022.
//

import UIKit

class AddFeedbackViewController: UIViewController {

    private var addFedbackView: AddFeedbackView {
        return self.view as! AddFeedbackView
    }

    let requestFactory = RequestFactory()
    var productIdNumber: Int

    init(productIdNumber: Int) {
        self.productIdNumber = productIdNumber
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = AddFeedbackView()
        view.config(ItemId: productIdNumber)
        view.delegate = self
        self.view = view

    }
     
    private func displayErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "ERROR",
                                      message: errorMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ALL OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func goToMainScreen(message: String) {
        let alert = UIAlertController(title: "ALL OK" ,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AddFeedbackViewController: AddFeedbackViewProtocol {
    func pressSaveFeedbackButton(feedbackResult: FeedbackResult) {
        let feedback = requestFactory.makeFeedbackRequestFactory()
        feedback.addFeedback(feedback: feedbackResult) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let result):
                    result.result == 1 ? self.goToMainScreen(message: result.successMessage ?? "") : self.displayErrorMessage(result.errorMessage ?? "Undefined error.")
                    print(result)
                case .failure(let error):
                    self.displayErrorMessage(error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
        }

    }

}

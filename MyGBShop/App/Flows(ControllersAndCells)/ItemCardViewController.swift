//
//  ItemCardViewController.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 05.08.2022.
//

import UIKit

class ItemCardViewController: UIViewController {

    private var itemCardView: ItemCardView {
        return self.view as! ItemCardView
    }

    var productIdNumber: Int

    let requestFactory = RequestFactory()

    init(productIdNumber: Int) {
        self.productIdNumber = productIdNumber
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ItemCardView()
        getItem(itemId: productIdNumber)
        view.delegate = self
        self.view = view
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = false
    }

    func getItem(itemId: Int) {
        let ItemById = requestFactory.makeGetItemRequestFactory()
        ItemById.getItem(productIdNumber: itemId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let result):
                    print(result)
                    self.itemCardView.configure(result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension ItemCardViewController: ItemCardViewProtocol {
    func pressGetFeedbackButton() {
        navigationController?.pushViewController(GetFeedbackTableViewController(productIdNumber: productIdNumber), animated: true)
    }

    func pressAddFeedbackButton() {
        navigationController?.pushViewController(AddFeedbackViewController(productIdNumber: productIdNumber), animated: true)
    }

    func putToCartButtonPressed() {
        print("====================")
        print("ALERT: the user pressed PutToCartButton!")
        print("Item ID Is:")
        print(productIdNumber)
        print("====================")
    }
}

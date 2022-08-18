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
    var item: ItemByIdResult?

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
                    self.item = result
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func showAddToShoppingCartSuccessAlert() {
            let alert = UIAlertController(title: "Cart", message: "Item added to cart.", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "ОK", style: .default, handler: nil))
                 self.present(alert, animated: true, completion: nil)
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
        guard let item = item else { return }
                 let shoppingCart = requestFactory.makeShoppingCartRequestFactory()
                 let shoppingCartRequest = ShoppingCartRequest(itemId: item.itemId ?? 0, quantity: 1)
                 shoppingCart.addToShoppingCart(shoppingCart: shoppingCartRequest) { response in
                     switch response.result {
                     case .success:
                         DispatchQueue.main.async {
                             let item = AppShoppingCartItem(productIdNumber: item.itemId,
                                                      itemName: item.itemName,
                                                      price: item.price,
                                                      picUrl: item.picUrl)
                             AppShoppingCart.shared.items.append(item)
                             self.showAddToShoppingCartSuccessAlert()
                         }
                     case .failure(let error):
                         print(error.localizedDescription)
                     }
                 }
    }
}

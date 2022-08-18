//
//  ShoppingCartTableViewController.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 18.08.2022.
//

import UIKit

class ShoppingCartTableViewController: UITableViewController {

    let requestFactory = RequestFactory()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ShoppingCartTableViewCell.self, forCellReuseIdentifier: CatalogueTableViewCell.reuseIdentifier)
        tableView.register(ShoppingCartFooterTableViewCell.self, forHeaderFooterViewReuseIdentifier: ShoppingCartFooterTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.hidesBackButton = true
        navigationController?.navigationBar.isTranslucent = true
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
     
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if AppShoppingCart.shared.items.count == 0 {
            return 1
        } else {
            return AppShoppingCart.shared.items.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if AppShoppingCart.shared.items.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "The shopping cart is empty"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.reuseIdentifier) as? ShoppingCartTableViewCell
            cell?.configure(AppShoppingCart.shared.items[indexPath.row])
            cell?.delegate = self
            cell?.row = indexPath.row

            return cell ?? UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: ShoppingCartFooterTableViewCell.reuseIdentifier) as? ShoppingCartFooterTableViewCell else {return UITableViewCell()}
        footer.configure()
        footer.delegate = self

        return footer

    }

}

extension ShoppingCartTableViewController: ShoppingCartTableViewCellProtocol {
    func deleteItem(_ index: Int) {
        guard let itemName = AppShoppingCart.shared.items[index].itemName else { return }
        let shoppingCartFactory = requestFactory.makeShoppingCartRequestFactory()

        let request = ShoppingCartRequest(itemId: index, quantity: 1)

        let alert = UIAlertController(title: "Shopping cart", message: "Remove \(itemName) ?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yeph", style: .destructive, handler: { _ in
            AppShoppingCart.shared.items.remove(at: index)
            self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Nope", style: .default, handler: nil))

        shoppingCartFactory.deleteFromShoppingCart(shoppingCart: request)  { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }

    }
}


extension ShoppingCartTableViewController: ShoppingCartFooterTableViewCellProtocol {
    func pressPayButton() {
        let shoppingCartFactory = requestFactory.makeShoppingCartRequestFactory()
        let user = User(id: 123)
         let alert = UIAlertController(title: "Cart", message:"Thank u 4 shopping", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОK", style: .default, handler: {_ in
            UIView.animate(withDuration: 0.2) {
                self.tabBarController?.selectedIndex = 0
            }
        }))
        shoppingCartFactory.payForShoppingCart(user: user) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: {
                         AppShoppingCart.shared.items = []
                         self.tableView.reloadData()
                    })
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}

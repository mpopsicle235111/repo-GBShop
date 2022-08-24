//
//  CatalogueTableViewController.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 30.07.2022.
//

import UIKit
import FirebaseCrashlytics

 class CatalogueTableViewController: UITableViewController {

     let requestFactory = RequestFactory()
     var catalogue: CatalogueResult = CatalogueResult(pageNumber: 0, items: [])

     override func viewDidLoad() {
         super.viewDidLoad()
         tableView.register(CatalogueTableViewCell.self, forCellReuseIdentifier: CatalogueTableViewCell.reuseIdentifier)
         tableView.dataSource = self
         tableView.delegate = self
         getCatalogue(pageNumber: 1, categoryNumber: 1)
         
         //Added for Crashlytics
         GALogger.logEvent(name: "catalogueViewed", key: "ResultIs", value: "Success")
         
         
     }

     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(false, animated: true)
         navigationController?.navigationBar.topItem?.hidesBackButton = true
         navigationController?.navigationBar.isTranslucent = true
     }

     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         navigationController?.setNavigationBarHidden(true, animated: false)
     }
     
     override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return catalogue.items.count
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogueTableViewCell.reuseIdentifier, for: indexPath) as? CatalogueTableViewCell else {return UITableViewCell()}

         cell.configure(catalogue.items[indexPath.row])

         return cell
     }

     func getCatalogue(pageNumber: Int, categoryNumber: Int) {
         let catalogue = requestFactory.makeGetCatalogueRequestFactory()

         catalogue.getCatalogue(pageNumber: pageNumber,
                            categoryNumber: categoryNumber) { [weak self] response in
             switch response.result {
             case .success(let result):
                 self?.catalogue = result
                 print(result)
                 DispatchQueue.main.async {
                     self?.tableView.reloadData()
                 }
             case .failure(let error):
                 print(error.localizedDescription)
             }
         }
     }
     
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              //Used before:
              //let itemId = catalogue.items[indexPath.row].itemId ?? 0
              //Now with Crashlytics:
         guard let itemId = catalogue.items[indexPath.row].itemId else {
             Crashlytics.crashlytics().log("itemIdDoesNotExist")
             return
         }
              

              navigationController?.pushViewController(ItemCardViewController(productIdNumber: itemId), animated: true)
          }


 }

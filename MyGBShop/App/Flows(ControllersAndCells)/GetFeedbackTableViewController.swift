//
//  GetFeedbackTableViewController.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 05.08.2022.
//

import UIKit

class GetFeedbackTableViewController: UITableViewController {

    let requestFactory = RequestFactory()

    var feedback = [FeedbackResult]()
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
        tableView.register(GetFeedbackTableViewCell.self, forCellReuseIdentifier: GetFeedbackTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        getFeedback(itemId: productIdNumber)


    }
     
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedback.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GetFeedbackTableViewCell.reuseIdentifier, for: indexPath) as? GetFeedbackTableViewCell else {return UITableViewCell()}

        let feedbackItem = feedback[indexPath.row]
        cell.configure(feedbackItem)

        return cell
    }

    func getFeedback(itemId: Int) {
        let feedbackItem = requestFactory.makeFeedbackRequestFactory()

        feedbackItem.getFeedback(productIdNumber: itemId) { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.feedback = result
                print(result)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }

}

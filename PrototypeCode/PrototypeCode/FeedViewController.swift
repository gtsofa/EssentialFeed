//
//  FeedViewController.swift
//  PrototypeCode
//
//  Created by Julius on 05/07/2022.
//

import UIKit

class FeedViewController: UITableViewController {
    // MARK: - Properties
    private let feed = FeedImageViewModel.prototypeFeed
    
    let feedId = "feed cell id"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        title = "My Feed"
        configureTableView()
    }
    
    func configureTableView(){
        
        tableView.register(FeedImageCell.self, forCellReuseIdentifier: feedId)
        
    }

}

// MARK: - TableViewDelegate/TableViewDatasource
extension FeedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: feedId, for: indexPath) as! FeedImageCell
        let model = feed[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}

extension FeedImageCell {
    func configure(with model: FeedImageViewModel) {
        locationLabel.text = model.location
        pinImageView.isHidden = model.location == nil
        locationLabel.isHidden = model.location == nil
        
        descLabel.text = model.description
        descLabel.isHidden = model.description == nil
        
        fadeIn(UIImage(named: model.imageName))
    }
}


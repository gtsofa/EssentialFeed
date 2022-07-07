//
//  FeedViewController.swift
//  PrototypeCode
//
//  Created by Julius on 05/07/2022.
//

import UIKit

class FeedViewController: UITableViewController {
    // MARK: - Properties
<<<<<<< HEAD
    private let feed = FeedImageViewModel.prototypeFeed
    
=======
    //let tableView = UITableView()
>>>>>>> 1466e90904f28dc282962e7c3354ebdbd2009648
    let feedId = "feed cell id"

    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
=======

>>>>>>> 1466e90904f28dc282962e7c3354ebdbd2009648
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
<<<<<<< HEAD
=======
        view.backgroundColor = .white
>>>>>>> 1466e90904f28dc282962e7c3354ebdbd2009648
        title = "My Feed"
        configureTableView()
    }
    
    func configureTableView(){
<<<<<<< HEAD
        
        tableView.register(FeedImageCell.self, forCellReuseIdentifier: feedId)
        
=======
        //tableView.delegate = self
        //tableView.dataSource = self
        
        tableView.register(FeedImageCell.self, forCellReuseIdentifier: feedId)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
>>>>>>> 1466e90904f28dc282962e7c3354ebdbd2009648
    }

}

// MARK: - TableViewDelegate/TableViewDatasource
extension FeedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
        return feed.count
=======
        return 10
>>>>>>> 1466e90904f28dc282962e7c3354ebdbd2009648
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: feedId, for: indexPath) as! FeedImageCell
<<<<<<< HEAD
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

=======
        
        return cell
    }
}

class FeedImageCell: UITableViewCell {
    // MARK: - IB + Labels
    let outerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hex("FFFFFF")
        view.layer.cornerRadius = 22.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 360).isActive = true//300
        view.clipsToBounds = true
        return view
    }()
    
    let feedImageContainerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor.hex("E3E3E3")
        cv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.cornerRadius = 22.0
        cv.clipsToBounds = true
        return cv
    }()
    
    lazy var pinImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "pin")
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var feedImageView: UIImageView = {
        let iv = UIImageView()
        iv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        iv.layer.cornerRadius = 22
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location, Location"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.hex("9B9B9B")
        label.numberOfLines = 0
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Description, Description, Description, Description, Description, Description, Description, Description, Description, Description, Description, Description"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.hex("4A4A4A")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       setupViews()
    }
    
    func setupViews() {
        backgroundColor = .clear
        
        addSubview(outerContainer)
        outerContainer.addSubview(feedImageContainerView)
        addSubview(feedImageView)
        addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            outerContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            outerContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            outerContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            outerContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)])
        
        let locationContainer = UIStackView(arrangedSubviews: [pinImageView, locationLabel])
        locationContainer.axis = .horizontal
        locationContainer.spacing = 6
        locationContainer.distribution = .fill
        locationContainer.alignment = .fill
        addSubview(locationContainer)
        locationContainer.frame = CGRect(x: 20, y: 30, width: frame.width - 10, height: 28)
        
        feedImageContainerView.topAnchor.constraint(equalTo: locationContainer.bottomAnchor, constant: 10).isActive = true
        feedImageContainerView.leftAnchor.constraint(equalTo: outerContainer.leftAnchor, constant: 10).isActive = true
        feedImageContainerView.rightAnchor.constraint(equalTo: outerContainer.rightAnchor, constant: -10).isActive = true
        
        feedImageView.topAnchor.constraint(equalTo: feedImageContainerView.topAnchor, constant: 0).isActive = true
        feedImageView.leftAnchor.constraint(equalTo: outerContainer.leftAnchor, constant: 10).isActive = true
        feedImageView.rightAnchor.constraint(equalTo: outerContainer.rightAnchor, constant: -10).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: feedImageContainerView.bottomAnchor, constant: 10).isActive = true
        descLabel.leftAnchor.constraint(equalTo: outerContainer.leftAnchor, constant: 10).isActive = true
        descLabel.rightAnchor.constraint(equalTo: outerContainer.rightAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
>>>>>>> 1466e90904f28dc282962e7c3354ebdbd2009648

//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Julius on 30/06/2022.
//

import UIKit
import EssentialFeed

public final class ListViewController: UITableViewController, UITableViewDataSourcePrefetching, ResourceLoadingView, ResourceErrorView {
    
    private(set) public var errorView = ErrorView()
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, CellController> = {
        .init(tableView: tableView) { (tableView, index, controller) -> UITableViewCell? in
            
            controller.dataSource.tableView(tableView, cellForRowAt: index)
        }
    }()
    
    public var onRefresh: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureTableView()
        
        refresh()

    }
    
    private func configureTableView() {
        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
        tableView.tableHeaderView = errorView.makeContainer()
        
        errorView.onHide = { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.sizeTableHeaderToFit()
            self?.tableView.endUpdates()
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.sizeTableHeaderToFit()
    }
    
    @IBAction private func refresh() {
        onRefresh?()
    }
    
    public override func traitCollectionDidChange(_ previous: UITraitCollection?) {
        if previous?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            tableView.reloadData()
        }
    }
    
    public func display(_ cellControllers: [CellController]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CellController>()
        snapshot.appendSections([0])
        snapshot.appendItems(cellControllers, toSection: 0)
        dataSource.apply(snapshot)
    }
    
    public func display(_ viewModel: ResourceErrorViewModel) {
        errorView.message = viewModel.message
    }

    
    public func display(_ viewModel: ResourceLoadingViewModel) {
        refreshControl?.update(isRefreshing: viewModel.isLoading)
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let dl = cellController(forRowAt: indexPath)?.delegate
        dl?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let dsp = cellController(forRowAt: indexPath)?.dataSourcePrefetching
            dsp?.tableView(tableView, prefetchRowsAt: [indexPath])
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let dsp = cellController(forRowAt: indexPath)?.dataSourcePrefetching
            dsp?.tableView?(tableView, cancelPrefetchingForRowsAt: [indexPath])
        }
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> CellController? {
        dataSource.itemIdentifier(for: indexPath)
    }
    
}

//
//  ViewController.swift
//  ProductApp
//
//  Created by Chitra on 05/02/26.
//

import Foundation
import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noDataPlaceholderLabel: UILabel!
    
    var viewModel = ProductListViewModel(apiService: APIService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noDataPlaceholderLabel.isHidden = true
        self.navigationItem.hidesBackButton = false
        self.title = "Product List"
        self.registerCell()
        
        self.viewModel.delegate = self
        self.viewModel.fetchList()

    }
    
    private func registerCell() {
        self.tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            if viewModel.nextPageExist(),
               let page = self.viewModel.pagination?.page,
               self.viewModel.pageToRequest == page {
                self.viewModel.pageToRequest = page + 1
                self.viewModel.fetchList()
            }
        }
    }
    
    func showFooterLoader() {
        tableView.tableFooterView = makeTableFooterLoader()
    }

    func hideFooterLoader() {
        tableView.tableFooterView = nil
    }
    
    private func makeTableFooterLoader() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: tableView.frame.width,
                                              height: 60))

        let spinner = UIActivityIndicatorView(style: .large)

        spinner.startAnimating()
        footerView.addSubview(spinner)
        return spinner
    }
}

//MARK: - ProductList ViewModel Delegates
extension ProductListViewController: ProductListViewModelDelegate {
    
    func didUpdateProducts() {
        self.tableView.reloadData()
        self.noDataPlaceholderLabel.isHidden = !(self.viewModel.productArray.isEmpty)
    }
    
    func didFail(error: APIError) {
        switch error {
        case .invalidUrl:
            debugPrint("URL is not valid")
        case .decodingError:
            debugPrint("Decoding error")
        case .noInternet:
            self.navigationController?.pushNoConnectionViewController(onTapRetry: {
                self.viewModel.fetchList()
            })
        case .invalidResponse:
            debugPrint("Response is not valid")
        case .serverError:
            debugPrint("Server Error")
        }
    }
    
    func didUpdateLoading(_ isLoading: Bool) {
        isLoading ? showFooterLoader() : hideFooterLoader()
    }
}



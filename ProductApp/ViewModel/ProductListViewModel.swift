//
//  ProductListViewModel.swift
//  ProductApp
//
//  Created by Chitra on 05/02/26.
//

import Foundation

protocol ProductListViewModelDelegate: AnyObject {
    func didUpdateProducts()
    func didFail(error: APIError)
    func didUpdateLoading(_ isLoading: Bool)
}

class ProductListViewModel {
    private(set) var pagination: Pagination?
    private(set) var productArray: [Product] = []
    var pageToRequest = 1
    private var apiService: APIServiceProtocol!
    
    weak var delegate: ProductListViewModelDelegate?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchList() {
        self.delegate?.didUpdateLoading(true)
        self.apiService.fetchProducts(page: self.pageToRequest, completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.didUpdateLoading(false)
                
                switch result {
                case .success(let response):
                    self?.productArray.append(contentsOf: response.data)
                    self?.pagination = response.pagination
                    self?.delegate?.didUpdateProducts()
                case .failure(let error):
                    self?.delegate?.didFail(error: error)
                }
            }
        })
    }
    
    func nextPageExist() -> Bool {
        guard let pagination = self.pagination else { return false }
        let totalPages = (pagination.total/pagination.limit) + (pagination.total % pagination.limit)
        return pagination.page < totalPages
    }
    
}

//
//  ProductDetailViewController.swift
//  ProductApp
//
//  Created by Chitra on 06/02/26.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Details"
        self.setupDataOnUI()
    }
    
    private func setupDataOnUI() {
        guard let product else { return }
        productTitleLabel.text = product.title
        productDescLabel.text = product.description
        productCategoryLabel.text = "Category: \(product.category.capitalized)"
        productPriceLabel.text = "$\(product.price)"
        productImage.setImage(from: product.image)
    }

}

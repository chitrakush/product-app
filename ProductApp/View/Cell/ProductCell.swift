//
//  ProductCell.swift
//  ProductApp
//
//  Created by Chitra on 06/02/26.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupContent(product: Product) {
        productTitleLabel.text = product.title.capitalized
        productDescLabel.text = product.description
        productPriceLabel.text = "$\(product.price)"
        productCategoryLabel.text = "Category: \(product.category.capitalized)"
        productImage.setImage(from: product.image)
    }
}

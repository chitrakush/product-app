//
//  Utils.swift
//  ProductApp
//
//  Created by Chitra on 08/02/26.
//

import UIKit
import Foundation

extension UIImageView {
    func setImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard
                let data = data,
                let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}

extension UINavigationController {

    func pushDetailController(with product: Product) {
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
            vc.product = product
            self.pushViewController(vc, animated: true)
        }
    }
    
    func pushNoConnectionViewController(onTapRetry: (()->Void)?) {
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoConnectionViewController") as! NoConnectionViewController
            vc.onTapRetry = onTapRetry
            self.pushViewController(vc, animated: false)
        }
    }
}

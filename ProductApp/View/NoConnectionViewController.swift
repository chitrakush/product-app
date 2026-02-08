//
//  NoConnectionViewController.swift
//  ProductApp
//
//  Created by Chitra on 07/02/26.
//

import UIKit

class NoConnectionViewController: UIViewController {
    
    @IBOutlet weak var noConnectionLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    var onTapRetry: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func retryButtonTapped(_ sender: Any) {
        self.onTapRetry?()
        self.navigationController?.popViewController(animated: false)
    }
}

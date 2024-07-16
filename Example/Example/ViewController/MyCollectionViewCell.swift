//
//  MyCollectionViewCell.swift
//  Example
//
//  Created by iOS on 2024/7/16.
//

import UIKit

// MARK: - MyCollectionViewCell
final class MyCollectionViewCell: UICollectionViewCell, CellReusable {
    
    @IBOutlet weak var myLabel: UILabel!
    
    var indexPath: IndexPath = []
    
    func configure(with indexPath: IndexPath) {
        
        let randomLength = Int.random(in: 1...10)
        let randomString = String._random(length: randomLength)
        
        self.indexPath = indexPath
        myLabel.text = "\(indexPath) - \(randomString)"
        backgroundColor = UIColor._random()
    }
}

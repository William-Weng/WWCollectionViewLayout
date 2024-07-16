//
//  Extension.swift
//  Example
//
//  Created by William.Weng on 2024/1/1.
//

import UIKit

// MARK: - String (function)
extension String {
    
    /// [隨機字串](https://appcoda.com.tw/swift-random-number/)
    /// - Returns: String
    /// - Parameters:
    ///   - length: 字串長度
    ///   - digits: 要隨機選擇的字串
    static func _random(length: Int, by digits: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890") -> String {
        let element = Array(0..<length).compactMap { _ in return digits.randomElement() }
        return String(element)
    }
}

// MARK: - UIColor (static function)
extension UIColor {
    
    /// 隨機顏色
    /// - Returns: UIColor
    static func _random() -> UIColor { return UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)}
}

// MARK: - UICollectionView (function)
extension UICollectionView {
    
    /// 初始化Protocal
    /// - Parameter this: UICollectionViewDelegate & UICollectionViewDataSource
    func _delegateAndDataSource(with this: UICollectionViewDelegate & UICollectionViewDataSource) {
        self.delegate = this
        self.dataSource = this
    }
    
    /// 取得UICollectionViewCell
    /// - let cell = collectionView._reusableCell(at: indexPath) as MyCollectionViewCell
    /// - Parameter indexPath: IndexPath
    /// - Returns: 符合CellReusable的Cell
    func _reusableCell<T: CellReusable>(at indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else { fatalError("UICollectionViewCell Error") }
        return cell
    }
    
    /// [資料新增或刪除時的動作設定 - performBatchUpdates() => beginUpdates() + endUpdates()](https://ithelp.ithome.com.tw/articles/10225747)
    /// - Parameters:
    ///   - updates: [(() -> Void)?](https://medium.com/@howardsun/uicollectionview-performbatchupdates-最大的秘密-7fb214c81d17)
    ///   - completion: [((Bool) -> Void)?](https://developer.apple.com/documentation/uikit/uicollectionview/1618045-performbatchupdates)
    func _performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        
        self.performBatchUpdates {
            updates?()
        } completion: { isCompleted in
            completion?(isCompleted)
        }
    }
}

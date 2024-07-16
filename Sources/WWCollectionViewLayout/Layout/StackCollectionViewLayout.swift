//
//  StackCollectionViewLayout.swift
//  WWCollectionViewLayout
//
//  Created by William.Weng on 2024/7/16.
//

import UIKit

// MARK: - StackCollectionViewLayout
open class StackCollectionViewLayout: UICollectionViewLayout {
    
    public var itemSize = CGSize(width: 150, height: 150)       // item大小
    public var angles: [CGFloat]  = [0, 15, -30, -15, 30]       // item旋轉角度
    
    public override init() {
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return shouldInvalidateLayout(for: newBounds)
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributesForElements(self, in: rect)
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributesForItem(self, itemSize: itemSize, at: indexPath)
    }
}

// MARK: - 小工具
private extension StackCollectionViewLayout {
    
    /// 邊界發生變化時是否重新佈局 (prepareLayout / layoutAttributesForElements(in:))
    /// - Parameter newBounds: CGRect
    /// - Returns: Bool
    func shouldInvalidateLayout(for newBounds: CGRect) -> Bool {
        return false
    }
    
    /// 在該範圍下的全部屬性設定
    /// - Parameters:
    ///   - layout: StackCollectionViewLayout
    ///   - rect: CGRect
    /// - Returns: [UICollectionViewLayoutAttributes]?
    func layoutAttributesForElements(_ layout: StackCollectionViewLayout, in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
                
        guard let collectionView = collectionView else { return nil }
        
        let section = 0
        let itemCount = collectionView.numberOfItems(inSection: section)
        let attributesArray = (0..<itemCount).compactMap { layoutAttributesForItem(at: IndexPath(item: $0, section: section)) }
        
        return attributesArray
    }
    
    /// [重新設定每一個Item的屬性 (大小 / 位置 / 中點 / 前後位置關係)](https://www.hangge.com/blog/cache/detail_1605.html)
    /// - Parameters:
    ///   - layout: StackCollectionViewLayout
    ///   - itemSize: CGSize
    ///   - indexPath: IndexPath
    /// - Returns: UICollectionViewLayoutAttributes?
    func layoutAttributesForItem(_ layout: StackCollectionViewLayout, itemSize: CGSize, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let collectionView = layout.collectionView else { return nil }
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        attributes.size = itemSize
        attributes.center = center(for: collectionView)
        attributes.transform = transform(with: angles, at: indexPath)
        attributes.zIndex = zIndex(for: collectionView, at: indexPath)
        
        return attributes
    }
    
    /// 設定中點 (讓每個Item都在正中央)
    /// - Parameter collectionView: UICollectionView
    /// - Returns: CGPoint?
    func center(for collectionView: UICollectionView) -> CGPoint {
        let center = CGPoint(x: collectionView.bounds.width * 0.5, y: collectionView.bounds.height * 0.5)
        return center
    }
    
    /// 設定zIndex (讓第一個Item在最上面，以此類推，最後一個在最下面，疊起來)
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: IndexPath
    /// - Returns: Int
    func zIndex(for collectionView: UICollectionView, at indexPath: IndexPath) -> Int {
        let zIndex = collectionView.numberOfItems(inSection: indexPath.section) - indexPath.item
        return zIndex
    }
    
    /// 旋轉角度
    /// - Parameters:
    ///   - angles: [CGFloat]
    ///   - indexPath: IndexPath
    /// - Returns: CGAffineTransform
    func transform(with angles: [CGFloat], at indexPath: IndexPath) -> CGAffineTransform {
        
        let radian = (angles[indexPath.item % angles.count])._radian()
        let transform = CGAffineTransform(rotationAngle: radian)
        
        return transform
    }
}

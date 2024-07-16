//
//  GalleryCollectionViewLayout.swift
//  WWCollectionViewLayout
//
//  Created by William.Weng on 2024/7/16.
//

import UIKit

// MARK: - GalleryCollectionViewLayout
open class GalleryCollectionViewLayout: UICollectionViewFlowLayout {
    
    public var scale: CGFloat = 1.0    // 縮放比例
    
    public override func prepare() {
        super.prepare()
        initSetting()
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return shouldInvalidateLayout(for: newBounds)
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributesForElements(collectionView: collectionView, in: rect, scale: scale)
    }
        
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        return targetContentOffset(collectionView: collectionView, for: proposedContentOffset, with: velocity)
    }
}

// MARK: - 小工具
private extension GalleryCollectionViewLayout {
    
    /// 設定初始值 (方向 / 內邊距 / 最小間距)
    func initSetting() {
        
        guard let collectionView = collectionView else { return }
        
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = minimumLineSpacing(for: collectionView, itemSize: itemSize)
        self.sectionInset = sectionInset(for: collectionView, itemSize: itemSize)
    }
    
    /// 邊界發生變化時是否重新佈局 (prepareLayout / layoutAttributesForElements(in:))
    /// - Parameter newBounds: CGRect
    /// - Returns: Bool
    func shouldInvalidateLayout(for newBounds: CGRect) -> Bool {
        return true
    }
    
    /// [計算在可見範圍的item屬性 (縮放比例)](https://www.hangge.com/blog/cache/detail_1602.html)
    /// - Parameters:
    ///   - collectionView: UICollectionView?
    ///   - rect: CGRect
    ///   - scale: CGFloat
    /// - Returns: [UICollectionViewLayoutAttributes]?
    func layoutAttributesForElements(collectionView: UICollectionView?, in rect: CGRect, scale: CGFloat) -> [UICollectionViewLayoutAttributes]? {
        
        guard let layoutAttributesArray = super.layoutAttributesForElements(in: rect),
              let collectionView = collectionView
        else {
            return nil
        }
        
        let visiableRect = collectionView._visiableRect()
        let contentOffsetCenter = collectionView._contentOffsetCenter()
        let maxDeviation = collectionView.bounds.width * 0.5 + itemSize.width * 0.5
        
        for attributes in layoutAttributesArray {
            
            if !visiableRect.intersects(attributes.frame) { continue }
            
            let scale = 1 + (scale - abs(contentOffsetCenter.x - attributes.center.x) / maxDeviation)
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return layoutAttributesArray
    }
    
    /// 計算最終停留的位置 (會有一張停在畫面中間的item)
    /// - Parameters:
    ///   - collectionView:  UICollectionView?
    ///   - proposedContentOffset: CGPoint
    ///   - velocity: CGPoint
    /// - Returns: CGPoint
    func targetContentOffset(collectionView: UICollectionView?, for proposedContentOffset: CGPoint, with velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView,
              let lastRect = Optional.some(CGRect(origin: proposedContentOffset, size: collectionView.bounds.size)),
              let layoutAttributesArray = layoutAttributesForElements(in: lastRect)
        else {
            return .zero
        }
        
        let proposedContentOffsetCenter = collectionView._contentOffsetCenter(proposedContentOffset)
        var adjustOffsetX: CGFloat = .greatestFiniteMagnitude
        
        layoutAttributesArray.forEach { attributes in
            let deviation = attributes.center.x - proposedContentOffsetCenter.x
            if abs(deviation) < abs(adjustOffsetX) { adjustOffsetX = deviation }
        }
                        
        return CGPoint(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
    }
    
    /// 設定內邊距 (為了讓它顯示只有一行，而且可以滾到第一個跟最後一個)
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - itemSize: CGSize
    /// - Returns: UIEdgeInsets
    func sectionInset(for collectionView: UICollectionView, itemSize: CGSize) -> UIEdgeInsets {
        
        let left = (collectionView.bounds.width - itemSize.width) * 0.5
        let top = (collectionView.bounds.height - itemSize.height) * 0.5
        let sectionInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
        
        return sectionInset
    }
    
    /// 設定最小間距 (為了讓它在中間，而且只有一個)
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - itemSize: CGSize
    /// - Returns: CGFloat
    func minimumLineSpacing(for collectionView: UICollectionView, itemSize: CGSize) -> CGFloat {
        let lineSpacing = collectionView.bounds.width * 0.5 - itemSize.width
        return lineSpacing
    }
}

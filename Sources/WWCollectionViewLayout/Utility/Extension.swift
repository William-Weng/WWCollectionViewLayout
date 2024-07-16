//
//  Extension.swift
//  WWCollectionViewLayout
//
//  Created by William.Weng on 2024/7/16.
//

import UIKit

// MARK: - CGFloat (function)
extension CGFloat {
    
    /// 180° => π
    func _radian() -> CGFloat { return (self / 180.0) * .pi }
    
    /// π => 180°
    func _angle() -> CGFloat { return self * (180.0 / .pi) }
}

// MARK: - UICollectionView (function)
extension UICollectionView {
    
    /// 可視範圍
    /// - Returns: CGRect
    func _visiableRect() -> CGRect {
        
        let origin = CGPoint(x: contentOffset.x, y: contentOffset.y)
        let visiableRect = CGRect(origin: origin, size: frame.size)
        
        return visiableRect
    }
    
    /// 滾動時相對於畫面的中點
    /// - Parameter contentOffset: CGPoint?
    /// - Returns: CGPoint
    func _contentOffsetCenter(_ contentOffset: CGPoint? = nil) -> CGPoint {
        
        let _contentOffset = contentOffset ?? self.contentOffset
        let centerX = _contentOffset.x + bounds.width * 0.5
        let centerY = _contentOffset.y + bounds.height * 0.5
        
        return CGPoint(x: centerX, y: centerY)
    }
}

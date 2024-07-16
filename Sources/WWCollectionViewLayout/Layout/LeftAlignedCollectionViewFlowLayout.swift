//
//  LeftAlignedCollectionViewFlowLayout.swift
//  WWCollectionViewLayout
//
//  Created by William.Weng on 2024/7/16.
//

import UIKit

// MARK: - LeftAlignedCollectionViewFlowLayout
open class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return leftLayoutAttributesForElements(in: rect)
    }
}

// MARK: - 小工具
private extension LeftAlignedCollectionViewFlowLayout {
    
    /// [讓Cell依文字數量靠左對齊](https://likeabossapp.com/2018/11/11/客製-uicollectionviewflowlayout-讓-uicollectionview-靠左對齊/)
    /// - Parameter rect: CGRect
    /// - Returns: [UICollectionViewLayoutAttributes]?
    func leftLayoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in

            if layoutAttribute.frame.origin.y >= maxY { leftMargin = sectionInset.left }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}

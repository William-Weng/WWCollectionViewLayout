//
//  WWCollectionViewLayout.swift
//  WWCollectionViewLayout
//
//  Created by William.Weng on 2024/7/16.
//

import UIKit

// MARK: - WWCollectionViewLayout
open class WWCollectionViewLayout {
    
    private init() {}
    
    public struct Flow {
        
        /// [建立layout - 一般效果](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/用-flow-layout-的-collection-view-實現水平滑動的分頁畫面-328a24c9b6b5)
        /// - Returns: UICollectionViewFlowLayout
        public static func layout() -> UICollectionViewFlowLayout { return UICollectionViewFlowLayout() }
        
        private init() {}
    }
    
    public struct Stack {
        
        /// [建立layout - 堆疊效果](https://www.hangge.com/blog/cache/detail_1605.html)
        /// - Returns: StackCollectionViewLayout
        public static func layout() -> StackCollectionViewLayout { return StackCollectionViewLayout() }
        
        private init() {}
    }
    
    public struct Gallery {
        
        /// [建立layout - 畫廊效果](https://www.hangge.com/blog/cache/detail_1602.html)
        /// - Returns: GalleryCollectionViewLayout
        public static func layout() -> GalleryCollectionViewLayout { return GalleryCollectionViewLayout() }
        
        private init() {}
    }
    
    public struct LeftAlign {
        
        /// [建立layout - 向左對齊效果](https://likeabossapp.com/2018/11/11/客製-uicollectionviewflowlayout-讓-uicollectionview-靠左對齊/)
        /// - Returns: [LeftAlignedCollectionViewFlowLayout](https://playful-azure-alpaca-849.medium.com/swift-客製化collectionview-flow-layout-232d8de286e4)
        public static func layout() -> LeftAlignedCollectionViewFlowLayout { return LeftAlignedCollectionViewFlowLayout() }
        
        private init() {}
    }
}

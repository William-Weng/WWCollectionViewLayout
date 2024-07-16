//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/1/1.
//

import UIKit
import WWCollectionViewLayout

// MARK: - ViewController
final class ViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    @IBAction func flowLayout(_ sender: UIBarButtonItem) {
        
        let layout = WWCollectionViewLayout.Flow.layout()
        
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.sectionInset = .zero
        updateLayout(layout)
    }
    
    @IBAction func stackLayout(_ sender: UIBarButtonItem) {
        
        let layout = WWCollectionViewLayout.Stack.layout()
        
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.angles = [0, -15, -30, 15, 30]
        updateLayout(layout)
    }
    
    @IBAction func galleryLayout(_ sender: UIBarButtonItem) {
        
        let layout = WWCollectionViewLayout.Gallery.layout()
        
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scale = 1.2
        updateLayout(layout)
    }
    
    @IBAction func leftAlignLayout(_ sender: UIBarButtonItem) {
        
        let layout = WWCollectionViewLayout.LeftAlign.layout()
        layout.estimatedItemSize = CGSize(width: 100, height: 100)

        updateLayout(layout)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView._reusableCell(at: indexPath) as MyCollectionViewCell
        cell.configure(with: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {}

// MARK: - 小工具
private extension ViewController {
    
    func initSetting() {
        myCollectionView._delegateAndDataSource(with: self)
    }
    
    func updateLayout(_ layout: UICollectionViewLayout, animated: Bool = true) {
        myCollectionView.collectionViewLayout.invalidateLayout()
        myCollectionView.setCollectionViewLayout(layout, animated: animated)
    }
}

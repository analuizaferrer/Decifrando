//
//  MenuCollectionViewController.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 05/11/16.
//
//

import Foundation
import UIKit


class MenuCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        collectionView?.backgroundColor = UIColor.yellow
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundView?.backgroundColor = UIColor.brown
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
}

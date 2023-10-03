//
//  CollectionViewController.swift
//  AutoLayout1
//
//  Created by Asif on 25/09/23.
//

import UIKit


class CollectionViewController: UICollectionViewController {

    let dataSources: [String] = ["USA", "Brazil", "China","United Kingdom", "Japan", "Mexico", "India"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
    }
    
    // number of items in sections
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    // cell for item
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            countryCell.configure(with: dataSources[indexPath.row])
            print(dataSources[indexPath.row])
            cell = countryCell
        }
        
        return cell
    }
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Country: \(dataSources[indexPath.row])")
    }

   
}

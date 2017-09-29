//
//  ViewController.swift
//  CodingExercise
//
//  Created by Suslov Babu on 28/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var youtubeResultsCollectionView: UICollectionView!
    
    let margin: CGFloat = 10
    let cellsPerRow = 1
    
    var results: [YoutubeSearchItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupViews() {
        self.navigationController?.isNavigationBarHidden = true
        
        // collection view flow layout configuration
        guard let flowLayout = youtubeResultsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
    }
    
    // Fetch data and update the table
    func fetchData(text: String) {
        self.activityIndicator.startAnimating()
        YoutubeSearchAPI().search(text: text) { (response, errorString) in
            self.activityIndicator.stopAnimating()
            if errorString != nil || response == nil || response?.items?.count == 0 {
                self.showAlert("No results found!".localize())

            } else {
                self.results = response?.items
                self.youtubeResultsCollectionView.reloadData()
            }
        }
        
    }
    
    // show alert with a message
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:NSLocalizedString("OK".localize(), comment: ""), style: .default))
        self.present(alert, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text?.isEmpty)! {
            results = []
        }
        self.youtubeResultsCollectionView.reloadData()
        self.fetchData(text: searchBar.text!)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.isEmpty)! {
            results = []
            self.youtubeResultsCollectionView.reloadData()
            
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchCollectionReusableView", for: indexPath)
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = results?[indexPath.row]
        
        if item?.videoId != nil {
            let youtubePlayer = self.storyboard?.instantiateViewController(withIdentifier: "youtubePlayer") as! YoutubePlayerViewController
            youtubePlayer.videoID = (item?.videoId)!
            self.navigationController?.pushViewController(youtubePlayer, animated: true)
        } else {
            self.showAlert("Failed to load video".localize())
        }

        
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results != nil ? (results?.count)! : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YoutubeResultsCollectionViewCell", for: indexPath) as! YoutubeResultsCollectionViewCell
        let item = results?[indexPath.row]
        cell.setupCell(item)
        return cell;
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthConsidered = collectionView.bounds.size.width
        var heightConsidered = collectionView.bounds.size.height

        if widthConsidered > collectionView.bounds.size.height {
            widthConsidered = collectionView.bounds.size.height
            heightConsidered = collectionView.bounds.size.width
        }
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow)
        let itemWidth = ((widthConsidered - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: heightConsidered - 160)
    }
}

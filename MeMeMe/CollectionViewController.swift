//
//  CollectionViewController.swift
//  MeMeMe
//
//  Created by Rachel Paturi on 1/28/16.
//  Copyright © 2016 Rachel Paturi. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    
    var appDel: AppDelegate {
        return (UIApplication.sharedApplication().delegate as! AppDelegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Calculating and setting the layout for collection view
        let space: CGFloat = 2.0
        let dimension = (view.frame.size.width - (2 * space)) / 2.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionViewOutlet.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDel.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewNewMeme", forIndexPath: indexPath) as! CustomMemeCell
        
        let meme = appDel.memes[indexPath.row]
        
        cell.memeTopText.text = meme.topTextField
        cell.memeImage?.image = meme.image as? UIImage
        cell.memeBottomText.text = meme.bottomTextField
      
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "collectionViewDetail" {
            
            let indexPaths = collectionViewOutlet.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            
            let collectionDetailVC = segue.destinationViewController as! CollectionViewDetailViewController
            
            let memeImage = appDel.memes[indexPath.row]
                
            collectionDetailVC.meme = memeImage
                
        }
    }
    

}

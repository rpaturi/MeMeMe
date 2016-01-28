//
//  CollectionVC.swift
//  MeMeMe
//
//  Created by Rachel Paturi on 1/28/16.
//  Copyright © 2016 Rachel Paturi. All rights reserved.
//

import UIKit

class CollectionVC: UICollectionViewController {

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! CustomMemeCell
        
        let meme = memes[indexPath.row]
        
        let imageView = UIImageView(image: meme.memedImage as? UIImage)
        cell.memeImage = imageView
        cell.topTextLabel.text = meme.topTextField
        cell.bottomTextLabel.text = meme.bottomTextField
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

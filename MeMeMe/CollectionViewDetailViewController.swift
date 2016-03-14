//
//  CollectionViewDetailViewController.swift
//  MeMeMe
//
//  Created by Rachel Paturi on 2/2/16.
//  Copyright © 2016 Rachel Paturi. All rights reserved.
//

import UIKit

class CollectionViewDetailViewController: UIViewController {
    
    
    var meme: Meme?
    
    
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickedImage.image = meme!.memedImage as? UIImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "collectionViewEditMeme" {
            let collectionViewEditVC = segue.destinationViewController as! MemeViewController
            
            let originalMeme = meme
            collectionViewEditVC.meme = originalMeme
            collectionViewEditVC.isMemeBeingEdited = true
            
        }
    }
    
    
    

}

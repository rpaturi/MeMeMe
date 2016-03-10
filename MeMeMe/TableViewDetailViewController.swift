//
//  TableViewDetailViewController.swift
//  MeMeMe
//
//  Created by Rachel Paturi on 1/25/16.
//  Copyright © 2016 Rachel Paturi. All rights reserved.
//

import UIKit

class TableViewDetailViewController: UIViewController {

    var meme: Meme?
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var pickedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        parentViewController?.navigationController?.setNavigationBarHidden(true, animated: false)
        
        pickedImage.image = meme!.memedImage as? UIImage
        
        //Set nav bar title
        navBar.title = meme?.topTextField
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}

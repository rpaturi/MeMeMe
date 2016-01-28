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
    
    @IBOutlet weak var pickedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickedImage.image = meme!.memedImage as? UIImage
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
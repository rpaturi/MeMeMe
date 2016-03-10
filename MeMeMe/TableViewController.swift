//
//  SentMemeViewController.swift
//  MeMeMe
//
//  Created by Rachel Paturi on 1/12/16.
//  Copyright © 2016 Rachel Paturi. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var appDel: AppDelegate {
        return (UIApplication.sharedApplication().delegate as! AppDelegate)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDel.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")! as UITableViewCell
        let meme = appDel.memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topTextField
        cell.imageView?.image = meme.memedImage as? UIImage
        
        return cell

    }
    
    //Allow left-swipe to delete meme
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            appDel.memes.removeAtIndex(indexPath.row)
            
            let sections = NSIndexSet(index: 0)
            tableView.reloadSections(sections, withRowAnimation: .Fade)
        }
    }
    
    //Send selected cell's image information to TableViewDetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tableViewDetail" {
            let tableDetailVC = segue.destinationViewController as! TableViewDetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let memeImage = appDel.memes[indexPath.row]
                
                tableDetailVC.meme = memeImage
            }
        }
    }


}

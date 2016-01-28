//
//  ViewController.swift
//  MeMeMe
//
//  Created by Rachel Paturi on 1/12/16.
//  Copyright © 2016 Rachel Paturi. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var sentMemesHomeButton: UIBarButtonItem!
    
    let imagePicker = UIImagePickerController()
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        
        formateTextField(topTextField)
        
        formateTextField(bottomTextField)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        subscribeToKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .ScaleAspectFill
            imagePickerView.image = pickedImage
        }else {
            print("No image was picked.")
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shootAnImage(sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        imagePicker.cameraCaptureMode = .Photo
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Format Meme Text
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.clearsOnBeginEditing = false
    }
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)!,
        NSStrokeWidthAttributeName : -2.0,
        NSForegroundColorAttributeName :  UIColor.whiteColor()
    ]
    
    func formateTextField(textField: UITextField){
        textField.delegate = self
        textField.text = textField.placeholder
        textField.placeholder = nil
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.clearsOnBeginEditing = true
        textField.adjustsFontSizeToFitWidth = true
    }
    
    //Move the keyboard out of the way of bottom text
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillDisappear(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Create a UIImage that combines the Image View and the Textfields
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        toolbar.hidden = true
        //navbar.hidden = true
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        toolbar.hidden = false
        //navbar.hidden = false
        
        return memedImage
    }
    
    //Share/Save image via ActivityViewController
    @IBAction func shareImage(sender: AnyObject) {
        
        //Generate Meme
        meme = Meme( topTextField: topTextField.text!, bottomTextField: bottomTextField.text, image:
            imagePickerView.image, memedImage: generateMemedImage())
        
        //Add meme to the memes array in the App Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme!)
        
        if let memeImage = meme!.memedImage {
            let sharedMeme = [memeImage]
            let activityViewController = UIActivityViewController(activityItems: sharedMeme, applicationActivities: nil)
            
            self.presentViewController(activityViewController, animated: true, completion: nil)
            
            activityViewController.completionWithItemsHandler = {(activityType, completed:Bool, returnedItems:[AnyObject]?, error: NSError?) in
            
            // Return to the initial view controller once activity view action has taken place
                if (completed) {
                    let initialVC = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController")
                    UIApplication.sharedApplication().keyWindow?.rootViewController = initialVC
                }
            
            }
        } else {
            "There is nothing to share."
        }
    }
    
    //Rest meme generator
    @IBAction func cancel(sender: AnyObject) {
        imagePickerView.image = nil
        formateTextField(topTextField)
        topTextField.text = "TOP"
        formateTextField(bottomTextField)
        bottomTextField.text = "BOTTOM"
    }
    
}
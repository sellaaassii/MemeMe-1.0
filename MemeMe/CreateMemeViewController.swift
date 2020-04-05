//
//  ViewController.swift
//  ImagePickerTings
//
//  Created by Selasi Kudolo on 2020-03-29.
//  Copyright © 2020 Ewe Cat Productions. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var bottomTextEdit: UITextField!
    @IBOutlet weak var topTextEdit: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var shareMemeButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var memedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDefaultViewSettings()
    }
    
    func initializeDefaultViewSettings() {
        setupTextFieldStyle(topTextEdit, defaultText: "TOP")
        setupTextFieldStyle(bottomTextEdit, defaultText: "BOTTOM")
        imagePickerView.image = nil
        shareMemeButton.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func setupTextFieldStyle(_ textField: UITextField, defaultText: String) {
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .strokeWidth:  -4.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = ""
        textField.placeholder = defaultText
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextEdit.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect

        return keyboardSize.cgRectValue.height
    }

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        showImagePickerController(.photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        showImagePickerController(.camera)
    }
    
    func showImagePickerController(_ sourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
            shareMemeButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextEdit.text!, bottomText: bottomTextEdit.text!, originalImage: imagePickerView.image!, memedImage: memedImage!)
        
        // Add it to the memes array in the Application Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        hideToolbarsAndTextViews(true)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Show toolbar and navbar
        hideToolbarsAndTextViews(false)

        return memedImage
    }
    
    func hideToolbarsAndTextViews(_ isHidden: Bool) {
        topToolbar.isHidden = isHidden
        bottomToolbar.isHidden = isHidden
        
        if isHidden {
            if topTextEdit.text == "" {
                topTextEdit.isHidden = isHidden
            }
            
            if bottomTextEdit.text == "" {
                bottomTextEdit.isHidden = isHidden
            }
        } else {
            topTextEdit.isHidden = isHidden
            bottomTextEdit.isHidden = isHidden
        }
    }

    @IBAction func shareMeme(_ sender: Any) {
        self.memedImage = generateMemedImage()
        let items = [self.memedImage]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed:Bool, returnedItems:[Any]?, error: Error?) in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }

        present(activityViewController, animated: true)
    }
    
    @IBAction func cancelEditing(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


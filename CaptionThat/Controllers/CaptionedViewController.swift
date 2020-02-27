//
//  CaptionedViewController.swift
//  CaptionThat
//
//  Created by Dane Brazinski on 2/17/20.
//  Copyright © 2020 Dane Brazinski. All rights reserved.
//

import UIKit

class CaptionedViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var captionTextField: UITextField!
    
    
    var newPic: Picture!
    var captions = [Caption(text: "I am serious. And don't call me Shirley"),
                    Caption(text: "I'm about to do to you what Limp Bizkit\n did to music in the late '90s."),
                    Caption(text: "I'm in a glass case of emotion!"),
                    Caption(text: "I'll have what she's having."),
                    Caption(text: "Nothing to see here, move along")]
    
    
    override func loadView() {
        super.loadView()
        userImageView.image = newPic.image
        captionLabel.text = randomCaption()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        captionTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        captionLabel.text = textField.text
    }
    
    
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        captionLabel.text = "Default text"
    }
    
    func randomCaption() -> String {
        guard let caption = captions.randomElement() else {
            assertionFailure("Caption should not be nil")
            return ""
        }
        return caption.text
    }
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
            print("gesterure")
            captionTextField.resignFirstResponder()
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
            
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        userImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

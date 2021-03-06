//
//  ViewController.swift
//  Instagrid
//
//  Created by antoine radice on 21/02/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!
    @IBOutlet weak var selectedImage1: UIImageView!
    @IBOutlet weak var selectedImage2: UIImageView!
    @IBOutlet weak var selectedImage3: UIImageView!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var imageUp: UIStackView!
    @IBOutlet weak var image1: UIView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var buttonImage1: UIButton!
    @IBOutlet weak var image2: UIView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var buttonImage2: UIButton!
    @IBOutlet weak var imageDown: UIStackView!
    @IBOutlet weak var image3: UIView!
    @IBOutlet weak var buttonImage3: UIButton!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var image4: UIView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var buttonImage4: UIButton!
    var test = 0
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        // Do any additional setup after loading the view.

    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            
            swipeLabel.text = "swipe left to share"
            arrowImage.image = UIImage(named: "Arrow Left")
        }
    }
    @IBAction func didTapLayoutButton1(_ sender: UIButton) {
        selectedImage2.isHidden = true
        selectedImage3.isHidden = true
        selectedImage1.isHidden = false
        image2.isHidden = true
        image4.isHidden = false
    }
    
    @IBAction func didTapLayoutButton2(_ sender: UIButton) {
        selectedImage1.isHidden = true
        selectedImage2.isHidden = false
        selectedImage3.isHidden = true
        image4.isHidden = true
        image2.isHidden = false
    }
    @IBAction func didTapLayoutButton3(_ sender: UIButton) {
        selectedImage1.isHidden = true
        selectedImage2.isHidden = true
        selectedImage3.isHidden = false
        image2.isHidden = false
        image4.isHidden = false
    }


    func CameraOrLibrary() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didTapButtonImage1(_ sender: UIButton) {
        CameraOrLibrary()
        test = 1
        buttonImage1.setBackgroundImage(nil, for: .normal)
    }
    
    @IBAction func didTapButtonImage2(_ sender: UIButton) {
        CameraOrLibrary()
        test = 2
        buttonImage2.setBackgroundImage(nil, for: .normal)

    }
    @IBAction func didTapButtonImage3(_ sender: UIButton) {
        CameraOrLibrary()
        test = 3
        buttonImage3.setBackgroundImage(nil, for: .normal)

    }
    @IBAction func didTapButtonImage4(_ sender: UIButton) {
        CameraOrLibrary()
        test = 4
        buttonImage4.setBackgroundImage(nil, for: .normal)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        if test == 1 {
            imageView1.image = pickedImage
        } else if test == 2 {
            imageView2.image = pickedImage
        } else if test == 3 {
            imageView3.image = pickedImage
        } else if test == 4 {
            imageView4.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func swipeUp(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: mainView)
        switch sender.state {
            case .began, .changed:
                transformMainViewWith(sender)
            case .ended, .cancelled:
                mainView.transform = .identity
                
                if UIDevice.current.orientation.isLandscape == false {
                    if translation.y < 0 {
                        shareImage()
                    }
                }else {
                    if translation.x < 0 {
                        shareImage()
                    }
                }
            default:
                break
            }
    }
    private func transformMainViewWith(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: mainView)
        mainView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
    }
    
    private func shareImage() {
        UIGraphicsBeginImageContextWithOptions(self.mainView.frame.size, true, 0.0)
            self.mainView.drawHierarchy(in: self.mainView.bounds, afterScreenUpdates: false)
            let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let items = [img]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
}

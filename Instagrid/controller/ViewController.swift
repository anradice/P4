//
//  ViewController.swift
//  Instagrid
//
//  Created by antoine radice on 21/02/2021.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var mainView: LayoutView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var imageUp: UIStackView!
    @IBOutlet weak var buttonImage1: UIButton!
    @IBOutlet weak var buttonImage2: UIButton!
    @IBOutlet weak var imageDown: UIStackView!
    @IBOutlet weak var buttonImage3: UIButton!
    @IBOutlet weak var buttonImage4: UIButton!
    var imagePicker: ImagePickerManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePickerManager(delegate: self)
        // Do any additional setup after loading the view.
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            swipeLabel.text = "swipe left to share"
            arrowImage.image = UIImage(named: "Arrow Left")
        }
        if UIDevice.current.orientation.isPortrait {
            swipeLabel.text = "swipe up to share"
            arrowImage.image = UIImage(named: "Arrow Up")
        }
    }

    @IBAction func didTapLayoutButton1(_ sender: UIButton) {
        mainView.state = .layout1
    }

    @IBAction func didTapLayoutButton2(_ sender: UIButton) {
        mainView.state = .layout2
    }

    @IBAction func didTapLayoutButton3(_ sender: UIButton) {
        mainView.state = .layout3
    }

    @IBAction func didTapButtonImage1(_ sender: UIButton) {
        imagePicker?.CameraOrLibrary()
        self.mainView.imageState = .image1
    }

    @IBAction func didTapButtonImage2(_ sender: UIButton) {
        imagePicker?.CameraOrLibrary()
        self.mainView.imageState = .image2
    }

    @IBAction func didTapButtonImage3(_ sender: UIButton) {
        imagePicker?.CameraOrLibrary()
        self.mainView.imageState = .image3
    }

    @IBAction func didTapButtonImage4(_ sender: UIButton) {
        imagePicker?.CameraOrLibrary()
        self.mainView.imageState = .image4
    }
    
    @IBAction func swipeUp(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: mainView)
        let screenheight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width

        switch sender.state {
            case .began, .changed:
                transformMainViewWith(translation)
            case .ended, .cancelled:
                if UIDevice.current.orientation.isLandscape == false {
                    if translation.y < 0 {
                        UIView.animate(withDuration: 0.4, animations: {
                            self.mainView.transform = CGAffineTransform(translationX: 0, y: -screenheight)
                        })
                        shareImage()
                    } else {
                        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                            self.mainView.transform = .identity
                        }, completion:nil)
                    }
                } else if UIDevice.current.orientation.isLandscape == true {
                    
                    if translation.x < 0 {
                        UIView.animate(withDuration: 0.4, animations: {
                            self.mainView.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
                        })
                        shareImage()
                    } else {
                        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                            self.mainView.transform = .identity
                        }, completion:nil)
                    }
                }
            default:
                break
            }
    }

    private func transformMainViewWith(_ gesture: CGPoint) {
        mainView.transform = CGAffineTransform(translationX: 0, y: gesture.y)
        if UIDevice.current.orientation.isLandscape {
            mainView.transform = CGAffineTransform(translationX: gesture.x, y: 0)
        }
    }

    private func shareImage() {
        UIGraphicsBeginImageContextWithOptions(self.mainView.frame.size, true, 0.0)
            self.mainView.drawHierarchy(in: self.mainView.bounds, afterScreenUpdates: false)
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let items = [finalImage]
        let activityController = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(activityController, animated: true, completion: {
            self.mainView.transform = .identity
        })
    }
}

extension ViewController: ImagePickerDelegate {
    func selectedImage(image: UIImage) {
        self.mainView.setImage(image: image)
        if self.mainView.imageState == .image1 {
            buttonImage1.setBackgroundImage(nil, for: .normal)
        } else if self.mainView.imageState == .image2 {
            buttonImage2.setBackgroundImage(nil, for: .normal)
        } else if self.mainView.imageState == .image3 {
            buttonImage3.setBackgroundImage(nil, for: .normal)
        } else if self.mainView.imageState == .image4 {
            buttonImage4.setBackgroundImage(nil, for: .normal)
        }
    }
}

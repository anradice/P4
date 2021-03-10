//
//  ImagePickerManager.swift
//  Instagrid
//
//  Created by antoine radice on 08/03/2021.
//
import UIKit
import Foundation

protocol ImagePickerDelegate: class {
    func selectedImage(image: UIImage)
    func cancel()
}

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    let imagePicker = UIImagePickerController()
    typealias Controller = UIViewController & ImagePickerDelegate
    var controller: UIViewController?
    weak var delegate: ImagePickerDelegate?
    
    init(delegate: Controller) {
        super.init()
        self.controller = delegate
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.delegate = delegate
    }
    
    
    func CameraOrLibrary() {
        let alert = CustomAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .photoLibrary
            self.controller?.present(self.imagePicker, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .camera
            self.controller?.present(self.imagePicker, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            self.delegate?.cancel()
        }))

        controller?.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.delegate?.selectedImage(image: pickedImage)
        controller?.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.delegate?.cancel()
        controller?.dismiss(animated: true, completion: nil)
    }
}

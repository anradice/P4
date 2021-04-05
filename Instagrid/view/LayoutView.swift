//
//  LayoutView.swift
//  Instagrid
//
//  Created by antoine radice on 08/03/2021.
//

import UIKit

class LayoutView: UIView {
    @IBOutlet var image1: UIView!
    @IBOutlet var image2: UIView!
    @IBOutlet var image3: UIView!
    @IBOutlet var image4: UIView!
    @IBOutlet var selectedImage1: UIImageView!
    @IBOutlet var selectedImage2: UIImageView!
    @IBOutlet var selectedImage3: UIImageView!
    @IBOutlet var ImageView1: UIImageView!
    @IBOutlet var ImageView2: UIImageView!
    @IBOutlet var ImageView3: UIImageView!
    @IBOutlet var ImageView4: UIImageView!

    enum State{
        case layout1, layout2, layout3
    }
    enum ImageState{
        case image1, image2, image3, image4
    }
    var imageState: ImageState = .image1
    
    var state: State = .layout1 {
        didSet {
            setLayout(state)
        }
    }

    func setImage(image: UIImage) {
        switch imageState {
        case .image1:
            ImageView1.image = image
        case .image2:
            ImageView2.image = image
        case .image3:
            ImageView3.image = image
        case .image4:
            ImageView4.image = image
        }
    }
    
    private func setLayout(_ state: State) {
        switch state {
        case .layout1:
            image2.isHidden = true
            image4.isHidden = false
            selectedImage2.isHidden = true
            selectedImage3.isHidden = true
            selectedImage1.isHidden = false
        case .layout2:
            selectedImage1.isHidden = true
            selectedImage2.isHidden = false
            selectedImage3.isHidden = true
            image4.isHidden = true
            image2.isHidden = false
        case .layout3:
            selectedImage1.isHidden = true
            selectedImage2.isHidden = true
            selectedImage3.isHidden = false
            image2.isHidden = false
            image4.isHidden = false
        }
    }
}

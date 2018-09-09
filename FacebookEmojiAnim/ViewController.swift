//
//  ViewController.swift
//  FacebookEmojiAnim
//
//  Created by sreekanth reddy iragam reddy on 9/8/18.
//  Copyright © 2018 com.sree.objc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let emojiContainerView: UIView = {
           let view = UIView()
           view.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
           view.layer.cornerRadius = 9
           //view.clipsToBounds = true
           let images: [UIImage] = [#imageLiteral(resourceName: "em1"),#imageLiteral(resourceName: "em2"),#imageLiteral(resourceName: "em3"),#imageLiteral(resourceName: "em4"),#imageLiteral(resourceName: "em5")]
           let imagesViews = images.map({ (image) -> UIImageView in
             let imageView = UIImageView(image: image)
             imageView.layer.cornerRadius = (imageView.frame.height/2)
            imageView.backgroundColor = .gray
            imageView.isUserInteractionEnabled = true
             return imageView
           })
           let stackView = UIStackView(arrangedSubviews: imagesViews)
           stackView.spacing = 2
           stackView.distribution = .fillProportionally
           view.addSubview(stackView)
           stackView.frame = view.frame
           view.layer.cornerRadius = view.frame.height/2
           return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(hanldeLongPressRecognizer)))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func hanldeLongPressRecognizer(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            longPressGestureBegan(recognizer)
        } else if recognizer.state == .ended {
            emojiContainerView.removeFromSuperview()
        } else if recognizer.state == .changed {
            selectEmojiBegan(recognizer)
        }
    }
    
    private func longPressGestureBegan(_ recognizer: UILongPressGestureRecognizer) {
         view.addSubview(emojiContainerView)
        let centerX = (view.frame.width - emojiContainerView.frame.width)/2
        let tappedLocation = recognizer.location(in: view)
        emojiContainerView.transform = CGAffineTransform(translationX: centerX, y: tappedLocation.y)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.emojiContainerView.transform = CGAffineTransform(translationX: centerX, y: tappedLocation.y - self.emojiContainerView.frame.height)
        }, completion: nil)
        
    }
    
    private func selectEmojiBegan(_ recognizer: UILongPressGestureRecognizer) {
           let selectedLocation = recognizer.location(in: emojiContainerView)
           print(selectedLocation)
           let viewSelected = emojiContainerView.hitTest(selectedLocation, with: nil)
           // print("^^^^^^")

//
            if viewSelected is UIImageView {
                print("******")
                // viewSelected?.subviews.fi

                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    let stackView = self.emojiContainerView.subviews.first
                                stackView?.subviews.forEach({ (imageView) in
                                    imageView.transform = .identity
                                })
                    viewSelected?.transform = CGAffineTransform(translationX: 0, y: -50)
                }, completion: nil)
                
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


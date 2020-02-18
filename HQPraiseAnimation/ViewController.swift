//
//  ViewController.swift
//  HQPraiseAnimation
//
//  Created by admin on 2020/2/18.
//  Copyright © 2020 闫海强. All rights reserved.
//

import UIKit

let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width

class ViewController: UIViewController {

    
    let praiseAnimation = HQPraiseAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let btn1 = UIButton.init(frame: CGRect.init(x: ScreenWidth - 25 - 30, y: ScreenHeight - 100, width: 25, height: 25))
        btn1.setImage(UIImage.init(named: "player_praise_s"), for: .normal)
        view.addSubview(btn1)
        btn1.addTarget(self, action: #selector(btn1Click), for: .touchUpInside)
        
        
        
        let imageArr: [UIImage] = [(UIImage.init(named: "praise_sprite_0")!),
                        UIImage.init(named: "praise_sprite_1")!,
                        UIImage.init(named: "praise_sprite_2")!,
                        UIImage.init(named: "praise_sprite_3")!,
                        UIImage.init(named: "praise_sprite_4")!,
                        UIImage.init(named: "praise_sprite_5")!
        ]
        
        praiseAnimation.initWith(imageArray: imageArr, onView: self.view, point: CGPoint.init(x: btn1.frame.origin.x, y: btn1.frame.origin.y))
        praiseAnimation.leftSpacing = 10
        praiseAnimation.rightSpacing = 10
        praiseAnimation.speed = 1;

    }
    
    @objc func btn1Click() {
        praiseAnimation.startAnimate(count: 5)
    }
    
    
}


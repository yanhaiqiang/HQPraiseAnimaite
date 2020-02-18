//
//  HQPraiseAnimation.swift
//  HQPraiseAnimation
//
//  Created by admin on 2020/2/18.
//  Copyright © 2020 闫海强. All rights reserved.
//

import UIKit


class HQPraiseAnimation: NSObject {
    
    /// 动画对象大小 默认(25,25)
    public var imageSize: CGSize = CGSize.init(width: 25, height: 25)
    /// 动画移动高度 默认(200)
    public var animationH: CGFloat = 200
    /// 动画左右幅度 以起点位置为参照点 默认50
    public var leftSpacing: CGFloat = 50
    public var rightSpacing: CGFloat = 50
    /// 动画速度 默认 3
    public var speed: CGFloat = 3
    
    var imageArray: [UIImage] = []
    weak var onView: UIView?
    var point: CGPoint?
    /**
     * 初始化
     *
     * @param imageArray 动画的图片数组
     * @param view 展示层
     * @param point 动画起点位置
     * return HQPraiseAnimation
     */
    
    public func initWith(imageArray: [UIImage], onView: UIView, point: CGPoint) {
        self.imageArray = imageArray
        self.onView = onView
        self.point = point
    }
        
    /**
     * 开始动画
     *
     * @param count 一次动画展示的图片数量
     */
    
    public func startAnimate( count: Int) {
            
        for i in 0..<count {
            /// 是否需要随机展示图片
//            let random = imageArray.count
//            let index = arc4random_uniform(UInt32(random))
            let image = imageArray[Int(i)]
            let praise = HQPraiseImage.init(image: image)
            praise.frame = CGRect.init(x: point?.x ?? 0, y: point?.y ?? 0, width: imageSize.width, height: imageSize.height)
            praise.animateH = animationH
            praise.speed = speed
            praise.minX = point?.x ?? 0 - leftSpacing
            praise.maxX = praise.frame.maxX + rightSpacing
            onView?.addSubview(praise)
            praise.animate()
        }
    }
}



class HQPraiseImage: UIImageView {
    
    var speed: CGFloat = 3
    var animateH: CGFloat = 200
    
    /// x 方向移动的最小值
    var minX: CGFloat = 0
    /// x 方向移动的最大值
    var maxX: CGFloat = 0
    
    
    func animate() {
        
        let min = minX
        let random = maxX - minX
        /// 动画持续时长
        let animateDuration = CGFloat(arc4random_uniform(3)) + speed
        alpha = 0
        
        
        /// 1.缩放动画
        let scaleAnimate = CABasicAnimation.init(keyPath: "transform.scale")
        /// 缩放动画 时长 0.2秒 时间内 从 0.2倍放大到 1倍
        scaleAnimate.duration = 0.2
        scaleAnimate.fromValue = 0.2;
        scaleAnimate.toValue = 1;
        
        
        /// 2.x 方向位移动画
        let xAnimate = CAKeyframeAnimation.init(keyPath: "position.x")
        xAnimate.duration = CFTimeInterval(animateDuration)
        xAnimate.values = [(self.layer.position.x),(arc4random_uniform(UInt32(random))+UInt32(min)),(arc4random_uniform(UInt32(random))+UInt32(min)),(arc4random_uniform(UInt32(random))+UInt32(min))]
        
        /// 3.y 方向位移动画
        let yAnimate = CABasicAnimation.init(keyPath: "position.y")
        yAnimate.duration = CFTimeInterval(animateDuration)
        /// 淡入淡出-> 开始和结束的时候有减速效果
        yAnimate.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        /// 动画 从底部 到距离顶部  50 的随机数
        yAnimate.fromValue = self.frame.origin.y
        yAnimate.toValue = self.frame.origin.y - CGFloat(arc4random_uniform(50)) - animateH
        
        
        ///4. 透明度动画
        let opacityAnimate = CABasicAnimation.init(keyPath: "opacity")
        opacityAnimate.duration = CFTimeInterval(animateDuration+1);
        /// 透明度从 1-> 0
        opacityAnimate.fromValue = 1
        opacityAnimate.toValue = 0
        opacityAnimate.delegate = self
        
        /// 当动画结束后,layer会一直保持着动画最后的状态
        xAnimate.fillMode = .forwards
        /// 图层保持显示动画执行后的状态
        xAnimate.isRemovedOnCompletion = false
        
        yAnimate.fillMode = .forwards
        yAnimate.isRemovedOnCompletion = false
        
        scaleAnimate.fillMode = .forwards
        scaleAnimate.isRemovedOnCompletion = false
        
        opacityAnimate.fillMode = .forwards
        opacityAnimate.isRemovedOnCompletion = false
        
        layer.add(xAnimate, forKey: nil)
        layer.add(yAnimate, forKey: nil)
        layer.add(opacityAnimate, forKey: nil)
        layer.add(scaleAnimate, forKey: nil)
        
    }
}

extension HQPraiseImage: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        isHidden = true
        removeFromSuperview()
        layer.removeAllAnimations()
    }
}


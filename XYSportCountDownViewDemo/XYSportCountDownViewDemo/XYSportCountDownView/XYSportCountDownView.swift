//
//  XYSportCountDownView.swift
//  LuoNengWatch
//
//  Created by xiaoyan on 2021/11/3.
//  Copyright © 2021 iOSyan. All rights reserved.
//

import UIKit

class XYSportCountDownView: UIView {
    
    var completeBlock: (() -> ())?

    lazy var labelWidth = 200.0 {
        didSet {
            self.circleView.frame.size = CGSize(width: labelWidth, height: labelWidth)
        }
    }
    
    lazy var count = 4 {
        didSet {
            self.label.text = "\(count)"
            labelAnimation()
        }
    }
    
    lazy var timer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        return timer
    }()
    
    var circleView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black
        view.alpha = 0.1
        view.isHidden = true
        view.frame.size = CGSize(width: 100, height: 100)
        view.layer.cornerRadius = view.frame.size.width/2
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        let name = "DINAlternate-Bold"
        label.font = UIFont(name: name, size: 200)
//        printX(CommonTool.printAllFontNames())
//        label.font = UIFont.systemFont(ofSize: 200)
        label.textAlignment = .center
        label.textColor = .red
        label.frame.size = CGSize(width: self.labelWidth, height: self.labelWidth)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //延时1秒执行
        let time: TimeInterval = 0.5
        weak var weakSelf = self
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            weakSelf?.setup()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        self.addSubview(circleView)
        self.addSubview(label)
        
        // 让子控件居中于父控件
        self.circleView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        self.label.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        timer.fire()
    }
    
    // MARK: - 点击事件
    func labelAnimation() {
        let duration = 0.3
        UIView.animate(withDuration: duration) {
            self.label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { finished in
            self.label.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        let scale = self.frame.size.width / self.circleView.frame.size.width
        UIView.animate(withDuration: duration+0.2, delay: 0, options:.curveEaseInOut) {
            self.circleView.isHidden = false
            self.circleView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.circleView.alpha = 0.02
        } completion: { finished in
            self.circleView.isHidden = true
            self.circleView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.circleView.alpha = 0.1
        }
    }
    
    @objc func countDown() {
        self.count -= 1
        if self.count == 0 {
            self.timer.invalidate()
            self.removeFromSuperview()
            if let completeBlock = completeBlock {
                completeBlock()
            }
            return
        }
    }
    
    deinit {
        print("deinit")
    }
}

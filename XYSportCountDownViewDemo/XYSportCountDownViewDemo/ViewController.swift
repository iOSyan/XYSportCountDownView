//
//  ViewController.swift
//  XYSportCountDownViewDemo
//
//  Created by ecsage on 2022/6/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 添加倒数view
        let countDownView = XYSportCountDownView(frame:view.bounds)
        countDownView.backgroundColor = view.backgroundColor
        view.addSubview(countDownView)
        countDownView.completeBlock = {
            // 倒数完成
        }
    }


}


//
//  LWTSegementViewController.swift
//  LWTSegementController
//
//  Created by liaowentao on 17/3/14.
//  Copyright © 2017年 Haochuang. All rights reserved.
//

import UIKit

class LWTSegementViewController: UIViewController,UIScrollViewDelegate {

    private let titleWidth : CGFloat = 80
    private let titleHeight : CGFloat = 40
    private let ScreenWidth = UIScreen.main.bounds.size.width
    private let ScreenHeight = UIScreen.main.bounds.size.height
    
    //
    private var selectButton:UIButton?//选择的栏目
    private var sliderView:UIView?//滑块
    private var mainScrollView:UIScrollView?//下方controller的scrollview
    private var topScroll:UIScrollView?//上方的scrollview
    
    var titleArray = [String]()//存储栏目标题
    var buttonArray = [UIButton]()
    var controllerArray = [UIViewController]()//存储各栏目的controller

    /**创建上方滑动栏目*/
    func createTitleButton(){
        
        //滑动ScrollView
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width:self.ScreenWidth, height: self.titleHeight))
        scroll.contentSize = CGSize(width: self.titleArray.count * NSInteger(titleWidth), height: 40)
        scroll.bounces = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.flashScrollIndicators()
        scroll.backgroundColor = UIColor.gray
        self.view.addSubview(scroll)
        self.topScroll = scroll
        
        //栏目按钮
        for(index,value) in self.titleArray.enumerated(){
           let titleButton = UIButton(frame: CGRect(x: self.titleWidth * CGFloat(index), y: 0, width: self.titleWidth, height: self.titleHeight))
            titleButton.setTitle(value, for: .normal)
            titleButton.setTitleColor(UIColor.black, for: .normal)
            titleButton.backgroundColor = UIColor.white
            titleButton.tag = 100 + index
            titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            titleButton.addTarget(self, action: #selector(scrollViewSelectToIndex), for:.touchUpInside)
            scroll.addSubview(titleButton)
            if(index == 0){
                self.selectButton = titleButton
                self.selectButton?.setTitleColor(UIColor.orange, for: .normal)
            }
            self.buttonArray.append(titleButton)
        }
        
        //滑块
        let sliderView = UIView(frame: CGRect(x: 15, y: self.titleHeight - 2, width: self.titleWidth - 20, height: 2))
        sliderView.backgroundColor = UIColor.orange
        scroll.addSubview(sliderView)
        self.sliderView = sliderView;
        
    }
    
    /**创建下方主视图*/
    func createMainControllerScrollView(){
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.ScreenWidth, height: self.ScreenHeight))
        if (self.navigationController?.navigationBar) != nil {
            self.navigationController?.navigationBar.isTranslucent = false
            scrollView.frame = CGRect(x: 0, y: self.topScroll!.frame.maxY, width: self.ScreenWidth, height: self.ScreenHeight - self.titleHeight)
        }
        else{
            self.topScroll?.frame = CGRect(x: 0, y: 10, width: self.ScreenWidth, height: 40)
            scrollView.frame = CGRect(x: 0, y: (self.topScroll?.frame.maxY)!, width: self.ScreenWidth, height: self.ScreenHeight - self.titleHeight)
        }
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.init(white: 0.900, alpha: 1.000)
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.ScreenWidth * CGFloat(self.controllerArray.count), height: self.ScreenHeight - self.titleHeight)
        self.view.addSubview(scrollView)
        self.mainScrollView = scrollView
        
        for (index,value) in self.controllerArray.enumerated() {
            var view = UIView(frame: CGRect(x: self.ScreenWidth * CGFloat(index), y: 0, width: self.ScreenWidth, height: self.ScreenHeight))
            view = value.view
            scrollView.addSubview(view)
        }
    }
    
    //MARK: - buttonTap
    func scrollViewSelectToIndex(sender:UIButton!){
        
        self.selectButton(index: sender.tag - 100)
        
        UIView.animate(withDuration: 0) { 
            self.mainScrollView?.contentOffset = CGPoint(x: self.ScreenWidth * CGFloat(sender.tag - 100), y: 0)
        }
        
    }
    
    /**选择某个项目*/
    func selectButton(index:NSInteger){
        self.selectButton?.setTitleColor(UIColor.black, for: .normal)
        selectButton = self.buttonArray[index]
        self.selectButton?.setTitleColor(UIColor.orange, for: .normal)
        let rect = selectButton!.superview!.convert(selectButton!.frame, to: self.view)
        UIView .animate(withDuration: 0) { 
            let contentOffset = self.topScroll!.contentOffset;
            if contentOffset.x <= (self.ScreenWidth/2 - rect.origin.x - self.titleWidth/2)  {
                self.topScroll!.setContentOffset(CGPoint(x:0,y:contentOffset.y), animated: true)
                
            } else if contentOffset.x - (self.ScreenWidth/2 - rect.origin.x - self.titleWidth/2) + self.ScreenWidth >= CGFloat(self.titleArray.count) * self.titleWidth {
                self.topScroll!.setContentOffset(CGPoint(x:CGFloat(self.titleArray.count) * self.titleWidth - self.ScreenWidth,y:contentOffset.y), animated: true)

            } else {
                self.topScroll!.setContentOffset(CGPoint(x:contentOffset.x - (self.ScreenWidth/2 - rect.origin.x - self.titleWidth/2),y:contentOffset.y), animated: true)
            }
        }
    }
    
    //scrolllViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index : Double = Double(scrollView.contentOffset.x / self.ScreenWidth)
       
        self.sliderView?.frame = CGRect(x: (Double(self.titleWidth) * index + 15.0), y: Double(self.titleHeight) - 2.0, width: Double(self.titleWidth) - 30.0, height: 2.0)
        
        if (scrollView == scrollView) {
            self.selectButton(index: NSInteger(index));
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createTitleButton()
        self.createMainControllerScrollView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

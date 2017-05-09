//
//  HomeViewController.swift
//  WKDouYuZB
//
//  Created by wangkai on 17/5/9.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40;

class HomeViewController: UIViewController {
    
    //MARK:- 懒加载属性
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW,height: kTitleViewH);
        let titles = ["推荐","游戏","娱乐","趣玩"];
        let titleView = PageTitleView(frame:titleFrame,titles:titles);
        return titleView;
    }();
    
    private lazy var pageContentView: PageContentView = {
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH;
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH);
        var childVcs = [UIViewController]();
        for _ in 0..<4{
            let vc = UIViewController();
            vc.view.backgroundColor = UIColor(r:CGFloat(arc4random_uniform(255)), g:CGFloat(arc4random_uniform(255)), b:CGFloat(arc4random_uniform(255)));
            childVcs.append(vc);
        }
        let contentView = PageContentView(frame: contentFrame,childVcs:childVcs,parentViewController:self);
        return contentView;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //不需要调整UIscrollView的内边距
        automaticallyAdjustsScrollViewInsets = false;
        
        //1.设置UI界面
        setupUI();
        
        //2.添加TitleView
        view.addSubview(pageTitleView);
         
        //3.添加contentview
        view.addSubview(pageContentView);
    }
}

//MARK:-设置UI界面
extension HomeViewController{
    fileprivate func setupUI(){
        setupNavigationBar();
    }
    
    fileprivate func setupNavigationBar(){
        //设置左侧的item
        let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action:nil);//为了调整leftItem的位置
        fixedSpaceItem.width = -10;
        let leftItem = UIBarButtonItem(imageName: "logo");//用自定义的view原因是会有点击高亮效果
        navigationItem.leftBarButtonItems = [fixedSpaceItem,leftItem];

        //设置右侧的item
        let size = CGSize(width:30,height:30);
        let histyoryItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size);
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size);
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size);
        navigationItem.rightBarButtonItems = [fixedSpaceItem,histyoryItem,searchItem,qrcodeItem];
    }
}

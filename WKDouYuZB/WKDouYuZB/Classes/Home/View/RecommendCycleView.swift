//
//  RecommendCycleView.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/23.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]?{
        didSet{
            collectionView.reloadData();
            pageControl.numberOfPages = cycleModels?.count ?? 0;
            //默认滚到中间某一个位置
            let indexPath = IndexPath(row: (cycleModels?.count ?? 0)*100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            removeCyclefTimer();
            addCyclefTimer();
        }
    }
    
     //MARK:  控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        //设置改控件不随着父控件的拉伸而拉伸
        self.autoresizingMask = []
        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: Bundle.main), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        layout.itemSize = collectionView.bounds.size;
    }
}

//MARK: - 提供一个快速创建view的类方法
extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView;
    }
}

//MARK: - 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0)*10000;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell;
        let cycModel = cycleModels?[indexPath.item % cycleModels!.count]
        cell.cycleModel = cycModel;
        return cell;
    }
}

//MARK: - 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width*0.5;
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1);
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCyclefTimer();
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCyclefTimer();
    }
}

//MARK: - 对定时器的操作方法
extension RecommendCycleView{
    fileprivate func addCyclefTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeCyclefTimer(){
        cycleTimer?.invalidate();
        cycleTimer = nil;
    }
    
    @objc private func scrollToNext(){
        let currentOffsetX = collectionView.contentOffset.x;
        let offsetX = currentOffsetX + collectionView.bounds.width;
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

//
//  SegmentedViewController.swift
//  viossvc
//
//  Created by yaowang on 2016/10/28.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation

@objc protocol SegmentedViewControllerProtocol {
    @objc optional func segmentedViewController(_ index:Int) -> UIViewController?;
    @objc optional func segmentedViewControllerIdentifiers() -> [String]!;
}

class SegmentedViewController: UIViewController , SegmentedViewControllerProtocol {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    fileprivate var courrentShowController:UIViewController? = nil;
    fileprivate var dictViewControllers:Dictionary<Int,UIViewController?> = Dictionary<Int,UIViewController!>();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        initSegmentedControl();
        reloadViewControllers();
        
    }
    
    
    
    final func reloadViewControllers() {
        for(_,viewController) in dictViewControllers {
            viewController?.willMove(toParentViewController: nil);
            viewController?.removeFromParentViewController();
        }
        dictViewControllers.removeAll();
        segmentedControl.sendActions(for: .valueChanged);
    }
    
    func contentRect() -> CGRect {
        var rect:CGRect =  view.frame;
        rect.origin.y = 0.0;
        return rect;
    }
    
    final func didActionChangeValue(_ sender: AnyObject) {
        
        showViewController(segmentedControl.selectedSegmentIndex);
    }
    
    final func showViewController(_ index:Int) {
        segmentedControl.selectedSegmentIndex = index;
        _showViewController(getViewControllerAtIndex(index));
    }
    
    final func _showViewController(_ viewController:UIViewController?) {
        if viewController != nil {
            if courrentShowController != nil {
                self.transition(from: courrentShowController!, to: viewController!, duration: 0.5, options: UIViewAnimationOptions(), animations: nil, completion: { (Bool) in
                    if Bool {
                        viewController?.didMove(toParentViewController: self);
                        self.courrentShowController = viewController!;
                    }
                });
            }
            else {
                self.courrentShowController = viewController!;
                view .addSubview(viewController!.view);
            }
        }
        
    }
    
    final func getViewControllerAtIndex(_ index:Int) -> UIViewController? {
        var viewController:UIViewController? = dictViewControllers[index]!;
        if viewController == nil {
            viewController = createViewController(index);
            if viewController != nil  {
                dictViewControllers[index] = viewController;
                addChildViewController(viewController!);
                viewController!.view.frame = contentRect();
            }
        }
        return viewController;
    }
    
    final func createViewController(_ index:Int) -> UIViewController? {
        let svcProtocol:SegmentedViewControllerProtocol = self as SegmentedViewControllerProtocol;
        if( svcProtocol.segmentedViewController != nil ) {
            return svcProtocol.segmentedViewController?(index);
        }
        
        if( svcProtocol.segmentedViewControllerIdentifiers != nil ) {
            let identifiers:[String]! = svcProtocol.segmentedViewControllerIdentifiers!();
            return  storyboard?.instantiateViewController(withIdentifier: identifiers[index]);
        }
        
        return nil;
    }
    
    fileprivate func initSegmentedControl() {
        
        let textAttr = [NSForegroundColorAttributeName:UIColor.white/*,NSFontAttributeName:UIFont.systemFontOfSize(15)*/];
        segmentedControl.setTitleTextAttributes(textAttr, for: UIControlState());
        segmentedControl.setTitleTextAttributes(textAttr, for: UIControlState.selected);
        
        segmentedControl.addTarget(self, action: #selector(didActionChangeValue(_:)), for:.valueChanged);
    }
    
    
}


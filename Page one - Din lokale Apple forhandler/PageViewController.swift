//
//  PageViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 22.02.2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

//  View did load function
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.dataSource = self
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        
        
    }

//  Memory warning function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // Returns the view controller after the given view controller.
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < orderedViewControllers.count else {
            
            
            for value in view.subviews {
                if let scrollView = value as? UIScrollView {
                    scrollView.bounces = false
                }
            }
            return nil
            
        }
        
        guard orderedViewControllers.count > nextIndex else {
           
            return nil
        }
        
        
        
        return orderedViewControllers[nextIndex]
    

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            
            for value in view.subviews {
                if let scrollView = value as? UIScrollView {
                    scrollView.bounces = false
                }
            }
            
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            
            
            return nil
        }
        return orderedViewControllers[previousIndex]
        
    }
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "TabBarViewController"),
                self.newVc(viewController: "ServiceViewController")]
    }()
    

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

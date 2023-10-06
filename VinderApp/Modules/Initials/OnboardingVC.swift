//
//  OnboardVC.swift
//  VinderApp
//
//  Created by ios Dev on 25/09/2023.
//

import UIKit

class OnboardingVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var skipBtn: UIButton!
    @IBOutlet var descLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!

    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0

    //data for the slides
    var headings = ["Discover Matches", "Plan Active Sports", "Strike Up Messages"]
    var descs = ["Swipe through profiles of fellow sports lovers in your area. Whether you're into basketball, soccer, tennis or hockey.", "Instead of the usual discuss, why not suggest a soccer, a tennis match, or attending a live sports event together?","Share your favorite sports moments, discuss upcoming games, or simply get to know each other better."]

    var imgs = ["onBoardImg-1","onBoardImg-2","onBoardImg-3"]

    // MARK: - View life cycle

    // get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded()
        self.navigationController?.navigationBar.isHidden = true

        // to call viewDidLayoutSubviews() and get dynamic width and height of scrollview
        userDefault.setValue(true, forKey: USER_DEFAULT_firstTimeInstallApp_Key)
        
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<descs.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            // subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:10, width:self.view.frame.width-10, height:self.scrollView.frame.height-20)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 10)

            self.titleLbl.text = self.headings[index]
            self.descLbl.text = self.descs[index]
            slide.addSubview(imageView)
//            slide.addSubview(txt1)
            scrollView.addSubview(slide)
        }

        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(descs.count), height: scrollHeight)

        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0

        //initial state
        pageControl.numberOfPages = descs.count
        pageControl.currentPage = 0
        
        self.descLbl.text = self.descs[0]
        self.titleLbl.text = self.headings[0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Button Actions

    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    @IBAction func skipBtnAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let otherVCObj = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initialVC.rawValue) as? InitialVC
        self.navigationController?.pushViewController(otherVCObj!, animated: true)
    }
    
    // MARK: - Methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
        self.descLbl.text = self.descs[Int(page)]
        self.titleLbl.text = self.headings[Int(page)]
    }

}

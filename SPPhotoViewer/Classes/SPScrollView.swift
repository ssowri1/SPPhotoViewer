/*
 * CSScrollView
 * This CSScrollView is utility class to contain all the operations of UIScrollView
 * @category   PhotosApp
 * @package    com.PhotosApp
 * @version    1.0
 * @author     ssowri1
 * @copyright  Copyright (C) 2018 ssowri1. All rights reserved.
 */
import UIKit
public class SPScrollView: UIView {
    /// properties
    var images:[UIImage] = []
    var viewFrame = UIScreen.main.bounds
    var tapGesture = UITapGestureRecognizer()
    var zoomView = SPZoomView()
    var imageView = UIImageView()
    lazy var scrollView: UIScrollView = {
        let scrVw = UIScrollView()
        scrVw.showsHorizontalScrollIndicator = false
        scrVw.showsVerticalScrollIndicator = false
        scrVw.decelerationRate = UIScrollView.DecelerationRate.fast
        scrVw.isPagingEnabled = true
        scrVw.frame = self.viewFrame
        scrVw.contentSize = CGSize(width: self.viewFrame.size.width * CGFloat(self.images.count),
                                   height: self.viewFrame.size.height)
        return scrVw
    }()
    /// Initial setup
    override public func layoutSubviews() {
        setup()
    }
    func setup() {
        scrollView.frame = self.viewFrame
        scrollView.delegate = self
        for i in 0 ..< images.count {
            imageView = UIImageView(frame:CGRect(x: (viewFrame.size.width) * CGFloat(i),
                                                 y:0,
                                                 width: viewFrame.size.width,
                                                 height: viewFrame.size.height))
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            imageView.tag = i
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(actZoomPhoto))
            imageView.addGestureRecognizer(tapGesture)
            scrollView.addSubview(imageView)
        }
        self.addSubview(scrollView)
    }
    @objc func actZoomPhoto(sender: UITapGestureRecognizer) {
        let tappedImage = (images[(sender.view?.tag)!] as UIImage)
        zoomView.delegate = self
        self.zoomView.frame = CGRect(x: scrollView.contentOffset.x, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        imageView.bringSubviewToFront(self.zoomView)
        scrollView.addSubview(self.zoomView)
        zoomView.selectedImage(tappedImage)
        isZoomed = true
    }
}
// MARK:- Delegates
extension SPScrollView: ZoomViewDelegate {
    func closeView() {
        zoomView.removeFromSuperview()
        zoomView = SPZoomView()
    }
}
extension SPScrollView: UIScrollViewDelegate {
    private func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.currentPage
        zoomView.changedPage(currentPage)
    }
}
// MARK:- Extension
extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5*self.frame.size.width))/self.frame.width) + 1
    }
}

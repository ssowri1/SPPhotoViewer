/*
 * SPZoomView
 * This is base class of visual effect view to zoom the images
 * @category   PhotosApp
 * @package    com.PhotosApp
 * @version    1.0
 * @author     ssowri1
 * @copyright  Copyright (C) 2018 ssowri1. All rights reserved.
 */
import UIKit
/// this is used to close the existing zooming scrollview while scrolling
protocol ZoomViewDelegate: class {
    func closeView()
}
//MARK:- Public Properties
public var isZoomed = Bool()
public var previousPage = Int()
class SPZoomView: UIVisualEffectView {
    //MARK:- Private Properties
    var scrollView = UIScrollView()
    var imageView = UIImageView()
    weak var delegate: ZoomViewDelegate?
    let btnClose: UIButton = {
        var btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "iconClose"), for: .normal)
        btn.addTarget(self, action: #selector(actCloseView), for: .touchUpInside)
        return btn
    }()
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /// close the current zoomed view
    @objc func actCloseView() {
        delegate?.closeView()
    }
    override func layoutSubviews() {
        setup()
    }
    /// setup the UI
    func setup() {
        self.effect = UIBlurEffect(style: .dark)
        btnClose.frame = (CGRect(x: frame.size.width-30, y: 30, width: 15, height: 15))
        self.contentView.addSubview(btnClose)
    }
    /// Close the zoomed image while changing or scrolling our scrollview
    func changedPage(_ pageNumber: Int) {
        if isZoomed == true {
            isZoomed = false
            delegate?.closeView()
        }
    }
    /// append the selected image on scrollview to zoom
    func selectedImage(_ image: UIImage) {
        scrollView = SPZoomingScrollView(frame:CGRect(x:0 ,
                                                      y:0 ,
                                                      width:self.frame.size.width ,
                                                      height:self.frame.size.height))
        scrollView.delegate = self
        imageView = UIImageView(frame:scrollView.frame)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        contentView.addSubview(scrollView)
    }
}
// MARK:- Delegate
extension SPZoomView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

/*
 * SPZoomingScrollView
 * This is base class of scroll view.
 * @category   PhotosApp
 * @package    com.PhotosApp
 * @version    1.0
 * @author     ssowri1
 * @copyright  Copyright (C) 2018 ssowri1. All rights reserved.
 */
import UIKit
class SPZoomingScrollView: UIScrollView {
    override func layoutSubviews() {
        setup()
    }
    /// setup the minimum and maximum zooming scale
    func setup() {
        minimumZoomScale = 1.0
        maximumZoomScale = 3.0
    }
}

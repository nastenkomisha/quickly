//
//  Quickly
//

open class QSpinnerView : QView, IQSpinnerView {
    
    public var style: UIActivityIndicatorView.Style {
        set(value) {
            if self._indicator.style != value {
                let color = self._indicator.color
                self._indicator.style = value
                self._indicator.color = color
            }
        }
        get { return self._indicator.style }
    }
    public var color: UIColor? {
        set(value) { self._indicator.color = value }
        get { return self._indicator.color }
    }

    private var _indicator: UIActivityIndicatorView!

    open override var intrinsicContentSize: CGSize {
        get { return self._indicator.intrinsicContentSize }
    }

    open override func setup() {
        super.setup()

        self.backgroundColor = UIColor.clear

        self._indicator = UIActivityIndicatorView(frame: self.bounds)
        self._indicator.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.addSubview(self._indicator)
    }

    open func isAnimating() -> Bool  {
        return self._indicator.isAnimating
    }

    open func start() {
        self._indicator.startAnimating()
    }

    open func stop() {
        self._indicator.stopAnimating()
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self._indicator.sizeThatFits(size)
    }

    open override func sizeToFit() {
        return self._indicator.sizeToFit()
    }

}

//
//  Quickly
//

open class QMainViewController : QViewController {

    open var backgroundViewController: IQViewController? {
        willSet {
            guard let vc = self.backgroundViewController else { return }
            if self.isLoaded == true {
                vc.willDismiss(animated: false)
                vc.didDismiss(animated: false)
                if vc.isLoaded == true {
                    vc.view.removeFromSuperview()
                }
            }
            vc.parent = nil
        }
        didSet {
            guard let vc = self.backgroundViewController else { return }
            vc.parent = self
            if self.isLoaded == true {
                self._appendBackgroundController(vc)
                vc.willPresent(animated: false)
                vc.didPresent(animated: false)
            }
        }
    }
    open var contentViewController: IQViewController? {
        willSet {
            guard let vc = self.contentViewController else { return }
            if self.isLoaded == true {
                vc.willDismiss(animated: false)
                vc.didDismiss(animated: false)
                if vc.isLoaded == true {
                    vc.view.removeFromSuperview()
                }
            }
            vc.parent = nil
        }
        didSet {
            guard let vc = self.contentViewController else { return }
            vc.parent = self
            if self.isLoaded == true {
                self._appendContentController(vc)
                vc.willPresent(animated: false)
                vc.didPresent(animated: false)
            }
        }
    }
    open var modalContainerViewController: IQModalContainerViewController? {
        willSet {
            guard let vc = self.modalContainerViewController else { return }
            if self.isLoaded == true {
                vc.willDismiss(animated: false)
                vc.didDismiss(animated: false)
                if vc.isLoaded == true {
                    vc.view.removeFromSuperview()
                }
            }
            vc.parent = nil
        }
        didSet {
            guard let vc = self.modalContainerViewController else { return }
            vc.parent = self
            if self.isLoaded == true {
                self._appendModalContainer(vc)
                vc.willPresent(animated: false)
                vc.didPresent(animated: false)
            }
        }
    }
    open var pushContainerViewController: IQPushContainerViewController? {
        willSet {
            guard let vc = self.pushContainerViewController else { return }
            if self.isLoaded == true {
                vc.willDismiss(animated: false)
                vc.didDismiss(animated: false)
                if vc.isLoaded == true {
                    vc.view.removeFromSuperview()
                }
            }
            vc.parent = nil
        }
        didSet {
            guard let vc = self.pushContainerViewController else { return }
            vc.parent = self
            if self.isLoaded == true {
                self._appendPushContainer(vc)
                vc.willPresent(animated: false)
                vc.didPresent(animated: false)
            }
        }
    }
    open var dialogContainerViewController: IQDialogContainerViewController? {
        willSet {
            guard let vc = self.dialogContainerViewController else { return }
            if self.isLoaded == true {
                vc.willDismiss(animated: false)
                vc.didDismiss(animated: false)
                if vc.isLoaded == true {
                    vc.view.removeFromSuperview()
                }
            }
            vc.parent = nil
        }
        didSet {
            guard let vc = self.dialogContainerViewController else { return }
            vc.parent = self
            if self.isLoaded == true {
                self._appendDialogContainer(vc)
                vc.willPresent(animated: false)
                vc.didPresent(animated: false)
            }
        }
    }

    open override func didLoad() {
        if let vc = self.backgroundViewController {
            self._appendBackgroundController(vc)
        }
        if let vc = self.contentViewController {
            self._appendContentController(vc)
        }
        if let vc = self.modalContainerViewController {
            self._appendModalContainer(vc)
        }
        if let vc = self.dialogContainerViewController {
            self._appendDialogContainer(vc)
        }
        if let vc = self.pushContainerViewController {
            self._appendPushContainer(vc)
        }
    }

    open override func layout(bounds: CGRect) {
        self.backgroundViewController?.view.frame = bounds
        self.contentViewController?.view.frame = bounds
        self.modalContainerViewController?.view.frame = bounds
        self.dialogContainerViewController?.view.frame = bounds
        self.pushContainerViewController?.view.frame = bounds
    }

    open override func prepareInteractivePresent() {
        super.prepareInteractivePresent()
        self.backgroundViewController?.prepareInteractivePresent()
        self.contentViewController?.prepareInteractivePresent()
        self.modalContainerViewController?.prepareInteractivePresent()
        self.dialogContainerViewController?.prepareInteractivePresent()
        self.pushContainerViewController?.prepareInteractivePresent()
    }

    open override func cancelInteractivePresent() {
        super.cancelInteractivePresent()
        self.backgroundViewController?.cancelInteractivePresent()
        self.contentViewController?.cancelInteractivePresent()
        self.modalContainerViewController?.cancelInteractivePresent()
        self.dialogContainerViewController?.cancelInteractivePresent()
        self.pushContainerViewController?.cancelInteractivePresent()
    }

    open override func finishInteractivePresent() {
        super.finishInteractivePresent()
        self.backgroundViewController?.finishInteractivePresent()
        self.contentViewController?.finishInteractivePresent()
        self.modalContainerViewController?.finishInteractivePresent()
        self.dialogContainerViewController?.finishInteractivePresent()
        self.pushContainerViewController?.finishInteractivePresent()
    }

    open override func willPresent(animated: Bool) {
        super.willPresent(animated: animated)
        self.backgroundViewController?.willPresent(animated: animated)
        self.contentViewController?.willPresent(animated: animated)
        self.modalContainerViewController?.willPresent(animated: animated)
        self.dialogContainerViewController?.willPresent(animated: animated)
        self.pushContainerViewController?.willPresent(animated: animated)
    }

    open override func didPresent(animated: Bool) {
        super.didPresent(animated: animated)
        self.backgroundViewController?.didPresent(animated: animated)
        self.contentViewController?.didPresent(animated: animated)
        self.modalContainerViewController?.didPresent(animated: animated)
        self.dialogContainerViewController?.didPresent(animated: animated)
        self.pushContainerViewController?.didPresent(animated: animated)
    }

    open override func prepareInteractiveDismiss() {
        super.prepareInteractiveDismiss()
        self.backgroundViewController?.prepareInteractiveDismiss()
        self.contentViewController?.prepareInteractiveDismiss()
        self.modalContainerViewController?.prepareInteractiveDismiss()
        self.dialogContainerViewController?.prepareInteractiveDismiss()
        self.pushContainerViewController?.prepareInteractiveDismiss()
    }

    open override func cancelInteractiveDismiss() {
        super.cancelInteractiveDismiss()
        self.backgroundViewController?.cancelInteractiveDismiss()
        self.contentViewController?.cancelInteractiveDismiss()
        self.modalContainerViewController?.cancelInteractiveDismiss()
        self.dialogContainerViewController?.cancelInteractiveDismiss()
        self.pushContainerViewController?.cancelInteractiveDismiss()
    }

    open override func finishInteractiveDismiss() {
        super.finishInteractiveDismiss()
        self.backgroundViewController?.finishInteractiveDismiss()
        self.contentViewController?.finishInteractiveDismiss()
        self.modalContainerViewController?.finishInteractiveDismiss()
        self.dialogContainerViewController?.finishInteractiveDismiss()
        self.pushContainerViewController?.finishInteractiveDismiss()
    }

    open override func willDismiss(animated: Bool) {
        super.willDismiss(animated: animated)
        self.backgroundViewController?.willDismiss(animated: animated)
        self.contentViewController?.willDismiss(animated: animated)
        self.modalContainerViewController?.willDismiss(animated: animated)
        self.dialogContainerViewController?.willDismiss(animated: animated)
        self.pushContainerViewController?.willDismiss(animated: animated)
    }

    open override func didDismiss(animated: Bool) {
        super.didDismiss(animated: animated)
        self.backgroundViewController?.didDismiss(animated: animated)
        self.contentViewController?.didDismiss(animated: animated)
        self.modalContainerViewController?.didDismiss(animated: animated)
        self.dialogContainerViewController?.didDismiss(animated: animated)
        self.pushContainerViewController?.didDismiss(animated: animated)
    }

    open override func willTransition(size: CGSize) {
        super.willTransition(size: size)
        self.backgroundViewController?.willTransition(size: size)
        self.contentViewController?.willTransition(size: size)
        self.modalContainerViewController?.willTransition(size: size)
        self.dialogContainerViewController?.willTransition(size: size)
        self.pushContainerViewController?.willTransition(size: size)
    }

    open override func didTransition(size: CGSize) {
        super.didTransition(size: size)
        self.backgroundViewController?.didTransition(size: size)
        self.contentViewController?.didTransition(size: size)
        self.modalContainerViewController?.didTransition(size: size)
        self.dialogContainerViewController?.didTransition(size: size)
        self.pushContainerViewController?.didTransition(size: size)
    }

    open override func supportedOrientations() -> UIInterfaceOrientationMask {
        guard let cvc = self.contentViewController else { return super.supportedOrientations() }
        return cvc.supportedOrientations()
    }

    open override func preferedStatusBarHidden() -> Bool {
        guard let cvc = self.contentViewController else { return super.preferedStatusBarHidden() }
        guard let cdvc = self.dialogContainerViewController?.currentViewController else { return cvc.preferedStatusBarHidden() }
        return cdvc.preferedStatusBarHidden()
    }

    open override func preferedStatusBarStyle() -> UIStatusBarStyle {
        guard let cvc = self.contentViewController else { return super.preferedStatusBarStyle() }
        guard let cdvc = self.dialogContainerViewController?.currentViewController else { return cvc.preferedStatusBarStyle() }
        return cdvc.preferedStatusBarStyle()
    }

    open override func preferedStatusBarAnimation() -> UIStatusBarAnimation {
        guard let cvc = self.contentViewController else { return super.preferedStatusBarAnimation() }
        guard let cdvc = self.dialogContainerViewController?.currentViewController else { return cvc.preferedStatusBarAnimation() }
        return cdvc.preferedStatusBarAnimation()
    }

    private func _appendBackgroundController(_ viewController: IQViewController) {
        viewController.view.frame = self.view.bounds
        self.view.insertSubview(viewController.view, at: 0)
    }

    private func _appendContentController(_ viewController: IQViewController) {
        viewController.view.frame = self.view.bounds
        if let vc = self.backgroundViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else if let vc = self.modalContainerViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, belowSubview: vc.view)
        } else if let vc = self.dialogContainerViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, belowSubview: vc.view)
        } else if let vc = self.pushContainerViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, belowSubview: vc.view)
        } else {
            self.view.addSubview(viewController.view)
        }
    }

    private func _appendModalContainer(_ viewController: IQModalContainerViewController) {
        viewController.view.frame = self.view.bounds
        if let vc = self.contentViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else if let vc = self.backgroundViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else if let vc = self.dialogContainerViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, belowSubview: vc.view)
        } else if let vc = self.pushContainerViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, belowSubview: vc.view)
        } else {
            self.view.addSubview(viewController.view)
        }
    }

    private func _appendDialogContainer(_ viewController: IQDialogContainerViewController) {
        viewController.view.frame = self.view.bounds
        if let vc = self.modalContainerViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else if let vc = self.contentViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else if let vc = self.backgroundViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else if let vc = self.pushContainerViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, belowSubview: vc.view)
        } else {
            self.view.addSubview(viewController.view)
        }
    }
    
    private func _appendPushContainer(_ viewController: IQPushContainerViewController) {
        viewController.view.frame = self.view.bounds
        if let vc = self.dialogContainerViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else if let vc = self.modalContainerViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else if let vc = self.contentViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else if let vc = self.backgroundViewController, vc.view.superview == self.view {
            self.view.insertSubview(viewController.view, aboveSubview: vc.view)
        } else {
            self.view.addSubview(viewController.view)
        }
    }

}

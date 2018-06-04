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
            }
            vc.parent = nil
        }
        didSet {
            guard let vc = self.backgroundViewController else { return }
            vc.parent = self
            if self.isLoaded == true {
                self.appendBackgroundController(vc)
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
            }
            vc.parent = nil
        }
        didSet {
            guard let vc = self.contentViewController else { return }
            vc.parent = self
            if self.isLoaded == true {
                self.appendContentController(vc)
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
            }
            vc.parent = nil
        }
        didSet {
            guard let vc = self.pushContainerViewController else { return }
            vc.parent = self
            if self.isLoaded == true {
                self.appendPushContainer(vc)
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
            }
            vc.parent = nil
        }
        didSet {
            guard let vc = self.dialogContainerViewController else { return }
            vc.parent = self
            if self.isLoaded == true {
                self.appendDialogContainer(vc)
                vc.willPresent(animated: false)
                vc.didPresent(animated: false)
            }
        }
    }

    open override func didLoad() {
        if let vc = self.backgroundViewController {
            self.appendBackgroundController(vc)
        }
        if let vc = self.contentViewController {
            self.appendContentController(vc)
        }
        if let vc = self.pushContainerViewController {
            self.appendPushContainer(vc)
        }
        if let vc = self.dialogContainerViewController {
            self.appendDialogContainer(vc)
        }
    }

    open override func layout(bounds: CGRect) {
        if let vc = self.backgroundViewController {
            vc.view.frame = bounds
        }
        if let vc = self.contentViewController {
            vc.view.frame = bounds
        }
        if let vc = self.pushContainerViewController {
            vc.view.frame = bounds
        }
        if let vc = self.dialogContainerViewController {
            vc.view.frame = bounds
        }
    }

    open override func prepareInteractivePresent() {
        super.prepareInteractivePresent()
        if let vc = self.backgroundViewController {
            vc.prepareInteractivePresent()
        }
        if let vc = self.contentViewController {
            vc.prepareInteractivePresent()
        }
        if let vc = self.pushContainerViewController {
            vc.prepareInteractivePresent()
        }
        if let vc = self.dialogContainerViewController {
            vc.prepareInteractivePresent()
        }
    }

    open override func cancelInteractivePresent() {
        super.cancelInteractivePresent()
        if let vc = self.backgroundViewController {
            vc.cancelInteractivePresent()
        }
        if let vc = self.contentViewController {
            vc.cancelInteractivePresent()
        }
        if let vc = self.pushContainerViewController {
            vc.cancelInteractivePresent()
        }
        if let vc = self.dialogContainerViewController {
            vc.cancelInteractivePresent()
        }
    }

    open override func finishInteractivePresent() {
        super.finishInteractivePresent()
        if let vc = self.backgroundViewController {
            vc.finishInteractivePresent()
        }
        if let vc = self.contentViewController {
            vc.finishInteractivePresent()
        }
        if let vc = self.pushContainerViewController {
            vc.finishInteractivePresent()
        }
        if let vc = self.dialogContainerViewController {
            vc.finishInteractivePresent()
        }
    }

    open override func willPresent(animated: Bool) {
        super.willPresent(animated: animated)
        if let vc = self.backgroundViewController {
            vc.willPresent(animated: animated)
        }
        if let vc = self.contentViewController {
            vc.willPresent(animated: animated)
        }
        if let vc = self.pushContainerViewController {
            vc.willPresent(animated: animated)
        }
        if let vc = self.dialogContainerViewController {
            vc.willPresent(animated: animated)
        }
    }

    open override func didPresent(animated: Bool) {
        super.didPresent(animated: animated)
        if let vc = self.backgroundViewController {
            vc.didPresent(animated: animated)
        }
        if let vc = self.contentViewController {
            vc.didPresent(animated: animated)
        }
        if let vc = self.pushContainerViewController {
            vc.didPresent(animated: animated)
        }
        if let vc = self.dialogContainerViewController {
            vc.didPresent(animated: animated)
        }
    }

    open override func prepareInteractiveDismiss() {
        super.prepareInteractiveDismiss()
        if let vc = self.backgroundViewController {
            vc.prepareInteractiveDismiss()
        }
        if let vc = self.contentViewController {
            vc.prepareInteractiveDismiss()
        }
        if let vc = self.pushContainerViewController {
            vc.prepareInteractiveDismiss()
        }
        if let vc = self.dialogContainerViewController {
            vc.prepareInteractiveDismiss()
        }
    }

    open override func cancelInteractiveDismiss() {
        super.cancelInteractiveDismiss()
        if let vc = self.backgroundViewController {
            vc.cancelInteractiveDismiss()
        }
        if let vc = self.contentViewController {
            vc.cancelInteractiveDismiss()
        }
        if let vc = self.pushContainerViewController {
            vc.cancelInteractiveDismiss()
        }
        if let vc = self.dialogContainerViewController {
            vc.cancelInteractiveDismiss()
        }
    }

    open override func finishInteractiveDismiss() {
        super.finishInteractiveDismiss()
        if let vc = self.backgroundViewController {
            vc.finishInteractiveDismiss()
        }
        if let vc = self.contentViewController {
            vc.finishInteractiveDismiss()
        }
        if let vc = self.pushContainerViewController {
            vc.finishInteractiveDismiss()
        }
        if let vc = self.dialogContainerViewController {
            vc.finishInteractiveDismiss()
        }
    }

    open override func willDismiss(animated: Bool) {
        super.willDismiss(animated: animated)
        if let vc = self.backgroundViewController {
            vc.willDismiss(animated: animated)
        }
        if let vc = self.contentViewController {
            vc.willDismiss(animated: animated)
        }
        if let vc = self.pushContainerViewController {
            vc.willDismiss(animated: animated)
        }
        if let vc = self.dialogContainerViewController {
            vc.willDismiss(animated: animated)
        }
    }

    open override func didDismiss(animated: Bool) {
        super.didDismiss(animated: animated)
        if let vc = self.backgroundViewController {
            vc.didDismiss(animated: animated)
        }
        if let vc = self.contentViewController {
            vc.didDismiss(animated: animated)
        }
        if let vc = self.pushContainerViewController {
            vc.didDismiss(animated: animated)
        }
        if let vc = self.dialogContainerViewController {
            vc.didDismiss(animated: animated)
        }
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

    private func appendBackgroundController(_ viewController: IQViewController) {
        viewController.view.frame = self.view.bounds
        self.view.insertSubview(viewController.view, at: 0)
    }

    private func appendContentController(_ viewController: IQViewController) {
        viewController.view.frame = self.view.bounds
        if let vc = self.dialogContainerViewController {
            if vc.view.superview == self.view {
                self.view.insertSubview(viewController.view, belowSubview: vc.view)
            } else {
                self.view.addSubview(viewController.view)
            }
        } else if let vc = self.pushContainerViewController {
            if vc.view.superview == self.view {
                self.view.insertSubview(viewController.view, belowSubview: vc.view)
            } else {
                self.view.addSubview(viewController.view)
            }
        } else if let vc = self.backgroundViewController {
            if vc.view.superview == self.view {
                self.view.insertSubview(viewController.view, aboveSubview: vc.view)
            } else {
                self.view.addSubview(viewController.view)
            }
        } else {
            self.view.addSubview(viewController.view)
        }
    }

    private func appendPushContainer(_ viewController: IQPushContainerViewController) {
        viewController.view.frame = self.view.bounds
        if let vc = self.dialogContainerViewController {
            if vc.view.superview == self.view {
                self.view.insertSubview(viewController.view, aboveSubview: vc.view)
            } else {
                self.view.addSubview(viewController.view)
            }
        } else if let vc = self.contentViewController {
            if vc.view.superview == self.view {
                self.view.insertSubview(viewController.view, aboveSubview: vc.view)
            } else {
                self.view.addSubview(viewController.view)
            }
        } else if let vc = self.backgroundViewController {
            if vc.view.superview == self.view {
                self.view.insertSubview(viewController.view, aboveSubview: vc.view)
            } else {
                self.view.addSubview(viewController.view)
            }
        } else {
            self.view.addSubview(viewController.view)
        }
    }

    private func appendDialogContainer(_ viewController: IQDialogContainerViewController) {
        viewController.view.frame = self.view.bounds
        if let vc = self.pushContainerViewController {
            if vc.view.superview == self.view {
                self.view.insertSubview(viewController.view, belowSubview: vc.view)
            } else {
                self.view.addSubview(viewController.view)
            }
        } else if let vc = self.contentViewController {
            if vc.view.superview == self.view {
                self.view.insertSubview(viewController.view, aboveSubview: vc.view)
            } else {
                self.view.addSubview(viewController.view)
            }
        } else if let vc = self.backgroundViewController {
            if vc.view.superview == self.view {
                self.view.insertSubview(viewController.view, aboveSubview: vc.view)
            } else {
                self.view.addSubview(viewController.view)
            }
        } else {
            self.view.addSubview(viewController.view)
        }
    }

}

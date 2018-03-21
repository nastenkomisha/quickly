//
//  Quickly
//

open class QPushContainerViewController : QPlatformViewController, IQPushContainerViewController {

    public typealias PushViewControllerType = IQPushContainerViewController.ViewControllerType

    open var viewControllers: [PushViewControllerType] = []
    open var currentViewController: PushViewControllerType? {
        get { return self.viewControllers.first }
    }
    open var presentAnimation: IQPushViewControllerFixedAnimation = QPushViewControllerPresentAnimation()
    open var dismissAnimation: IQPushViewControllerFixedAnimation = QPushViewControllerDismissAnimation()
    open var interactiveDismissAnimation: IQPushViewControllerInteractiveAnimation? = QPushViewControllerInteractiveDismissAnimation()
    #if os(iOS)
    open lazy var interactiveDismissGesture: UIPanGestureRecognizer = self._prepareInteractiveDismissGesture()
    open var currentDismissViewController: ViewControllerType?
    open var currentInteractiveDismissAnimation: IQPushViewControllerInteractiveAnimation?
    #endif

    #if os(macOS)

    public override init(nibName: NSNib.Name?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.setup()
    }

    #elseif os(iOS)

    public override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.setup()
    }

    #endif

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    open func setup() {
    }

    open override func loadView() {
        self.view = QTransparentView()
    }

    open func willPresent(animated: Bool) {
        #if DEBUG
            print("\(NSStringFromClass(self.classForCoder)).willPresent(animated: \(animated))")
        #endif
    }

    open func didPresent(animated: Bool) {
        #if DEBUG
            print("\(NSStringFromClass(self.classForCoder)).didPresent(animated: \(animated))")
        #endif
    }

    open func willDismiss(animated: Bool) {
        #if DEBUG
            print("\(NSStringFromClass(self.classForCoder)).willDismiss(animated: \(animated))")
        #endif
    }

    open func didDismiss(animated: Bool) {
        #if DEBUG
            print("\(NSStringFromClass(self.classForCoder)).didDismiss(animated: \(animated))")
        #endif
    }

    open func presentPush(viewController: ViewControllerType, animated: Bool, completion: (() -> Void)?) {
        let currentViewController: ViewControllerType? = self.currentViewController
        self.viewControllers.append(viewController)
        viewController.containerViewController = self
        if self.isViewLoaded == true {
            if currentViewController == nil {
                self._present(viewController, animated: animated, completion: {
                    completion?()
                })
            }
        }
    }

    open func dismissPush(viewController: ViewControllerType, animated: Bool, completion: (() -> Void)?) {
        self._dismiss(viewController: viewController, animated: animated, presentAnimated: animated, skipInteractiveDismiss: true, completion: completion)
    }

    private func _present(_ viewController: ViewControllerType, animated: Bool, completion: (() -> Void)?) {
        self._appearViewController(viewController)
        if animated == true {
            let presentAnimation: IQPushViewControllerFixedAnimation = self._preparePresentAnimation(viewController)
            presentAnimation.prepare(viewController: viewController)
            presentAnimation.update(animated: animated, complete: { (completed: Bool) in
                completion?()
            })
        } else {
            completion?()
        }
    }

    open func _dismiss(viewController: ViewControllerType, animated: Bool, presentAnimated: Bool, skipInteractiveDismiss: Bool, completion: (() -> Void)?) {
        let currentViewController: ViewControllerType? = self.currentViewController
        if let index: Int = self.viewControllers.index(where: { (existViewController: ViewControllerType) -> Bool in
            return existViewController == viewController
        }) {
            self.viewControllers.remove(at: index)
            if self.isViewLoaded == true {
                if currentViewController === viewController {
                    #if os(iOS)
                        if skipInteractiveDismiss == true && self.interactiveDismissGesture.state != .possible {
                            let enabled: Bool = self.interactiveDismissGesture.isEnabled
                            self.interactiveDismissGesture.isEnabled = false
                            self.interactiveDismissGesture.isEnabled = enabled
                        }
                    #endif
                    if let nextViewController: ViewControllerType = self.currentViewController {
                        self._dismiss(viewController, animated: animated, completion: { [weak self] in
                            viewController.containerViewController = nil
                            if let strongify = self {
                                strongify._present(nextViewController, animated: presentAnimated, completion: {
                                    completion?()
                                })
                            } else {
                                completion?()
                            }
                        })
                    } else {
                        self._dismiss(viewController, animated: animated, completion: {
                            viewController.containerViewController = nil
                            completion?()
                        })
                    }
                } else {
                    self._dismiss(viewController, animated: false, completion: {
                        viewController.containerViewController = nil
                        completion?()
                    })
                }
            }
        }
    }

    private func _dismiss(_ viewController: ViewControllerType, animated: Bool, completion: (() -> Void)?) {
        if animated == true {
            let dismissAnimation: IQPushViewControllerFixedAnimation = self._prepareDismissAnimation(viewController)
            dismissAnimation.prepare(viewController: viewController)
            dismissAnimation.update(animated: animated, complete: { [weak self] (completed: Bool) in
                if let strongify = self {
                    strongify._disappearViewController(viewController)
                }
                completion?()
            })
        } else {
            self._disappearViewController(viewController)
            completion?()
        }
    }

    private func _appearViewController(_ viewController: PushViewControllerType) {
        self.addChildViewController(viewController)
        viewController.view.frame = self.view.bounds
        self.view.addSubview(viewController.view)
        #if os(iOS)
            viewController.didMove(toParentViewController: self)
            viewController.view.addGestureRecognizer(self.interactiveDismissGesture)
        #endif
    }

    private func _disappearViewController(_ viewController: PushViewControllerType) {
        #if os(iOS)
            viewController.view.removeGestureRecognizer(self.interactiveDismissGesture)
            viewController.willMove(toParentViewController: nil)
        #endif
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }

    private func _preparePresentAnimation(_ viewController: ViewControllerType) -> IQPushViewControllerFixedAnimation {
        if let animation: IQPushViewControllerFixedAnimation = viewController.presentAnimation {
            return animation
        }
        return self.presentAnimation
    }

    private func _prepareDismissAnimation(_ viewController: ViewControllerType) -> IQPushViewControllerFixedAnimation {
        if let animation: IQPushViewControllerFixedAnimation = viewController.dismissAnimation {
            return animation
        }
        return self.dismissAnimation
    }

    #if os(iOS)

    private func _prepareInteractiveDismissAnimation(_ viewController: ViewControllerType) -> IQPushViewControllerInteractiveAnimation? {
        if let animation: IQPushViewControllerInteractiveAnimation = viewController.interactiveDismissAnimation {
            return animation
        }
        return self.interactiveDismissAnimation
    }

    private func _prepareInteractiveDismissGesture() -> UIPanGestureRecognizer {
        let gesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self._interactiveDismissGestureHandler(_:)))
        gesture.delegate = self
        return gesture
    }

    @objc private func _interactiveDismissGestureHandler(_ sender: Any) {
        let position: CGPoint = self.interactiveDismissGesture.location(in: nil)
        let velocity: CGPoint = self.interactiveDismissGesture.velocity(in: nil)
        switch self.interactiveDismissGesture.state {
        case .began:
            guard
                let viewController: ViewControllerType = self.currentViewController,
                let interactiveDismissAnimation: IQPushViewControllerInteractiveAnimation = self._prepareInteractiveDismissAnimation(viewController)
                else {
                    return
            }
            self.currentDismissViewController = viewController
            self.currentInteractiveDismissAnimation = interactiveDismissAnimation
            interactiveDismissAnimation.prepare(viewController: viewController, position: position, velocity: velocity)
            break
        case .changed:
            guard let interactiveDismissAnimation: IQPushViewControllerInteractiveAnimation = self.currentInteractiveDismissAnimation else {
                return
            }
            interactiveDismissAnimation.update(position: position, velocity: velocity)
            break
        case .ended, .failed, .cancelled:
            guard
                let viewController: ViewControllerType = self.currentDismissViewController,
                let interactiveDismissAnimation: IQPushViewControllerInteractiveAnimation = self.currentInteractiveDismissAnimation
                else {
                    return
            }
            if interactiveDismissAnimation.canFinish == true {
                interactiveDismissAnimation.finish({ [weak self] (completed: Bool) in
                    guard let strongify = self else { return }
                    strongify._dismiss(viewController: viewController, animated: false, presentAnimated: true, skipInteractiveDismiss: false, completion: {
                        strongify.currentDismissViewController = nil
                        strongify.currentInteractiveDismissAnimation = nil
                    })
                })
            } else {
                interactiveDismissAnimation.cancel({ [weak self] (completed: Bool) in
                    guard let strongify = self else { return }
                    strongify.currentDismissViewController = nil
                    strongify.currentInteractiveDismissAnimation = nil
                })
            }
            break
        default:
            break
        }
    }

    #endif

}

#if os(iOS)

    extension QPushContainerViewController : UIGestureRecognizerDelegate {

        open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            guard let viewController: ViewControllerType = self.currentViewController else {
                return false
            }
            let location: CGPoint = gestureRecognizer.location(in: viewController.contentViewController.view)
            return viewController.contentViewController.view.point(inside: location, with: nil)
        }

    }

#endif
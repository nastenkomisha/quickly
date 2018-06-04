//
//  Quickly
//

// MARK: - QDialogViewControllerSizeBehaviour -

public enum QDialogViewControllerSizeBehaviour {
    case fit(min: CGFloat, max: CGFloat)
    case fill(before: CGFloat, after: CGFloat)
}

// MARK: - QDialogViewControllerVerticalAlignment -

public enum QDialogViewControllerVerticalAlignment {
    case top(offset: CGFloat)
    case center(offset: CGFloat)
    case bottom(offset: CGFloat)

    public var offset: CGFloat {
        get {
            switch self {
            case .top(let offset): return offset
            case .center(let offset): return offset
            case .bottom(let offset): return offset
            }
        }
    }
}

// MARK: - QDialogViewControllerHorizontalAlignment -

public enum QDialogViewControllerHorizontalAlignment {
    case left(offset: CGFloat)
    case center(offset: CGFloat)
    case right(offset: CGFloat)

    public var offset: CGFloat {
        get {
            switch self {
            case .left(let offset): return offset
            case .center(let offset): return offset
            case .right(let offset): return offset
            }
        }
    }
}

// MARK: - IQDialogViewControllerFixedAnimation -

public protocol IQDialogViewControllerFixedAnimation : IQFixedAnimation {

    func prepare(viewController: IQDialogViewController)

}

// MARK: - IQDialogViewControllerInteractiveAnimation -

public protocol IQDialogViewControllerInteractiveAnimation : IQInteractiveAnimation {

    func prepare(viewController: IQDialogViewController, position: CGPoint, velocity: CGPoint)

}

// MARK: - IQDialogContainerViewController -

public protocol IQDialogContainerViewController : IQViewController {

    typealias BackgroundView = UIView & IQDialogContainerBackgroundView

    var viewControllers: [IQDialogViewController] { get }
    var currentViewController: IQDialogViewController? { get }
    var backgroundView: BackgroundView? { get }
    var presentAnimation: IQDialogViewControllerFixedAnimation { get }
    var dismissAnimation: IQDialogViewControllerFixedAnimation { get }
    var interactiveDismissAnimation: IQDialogViewControllerInteractiveAnimation? { get }

    func presentDialog(viewController: IQDialogViewController, animated: Bool, completion: (() -> Swift.Void)?)
    func dismissDialog(viewController: IQDialogViewController, animated: Bool, completion: (() -> Swift.Void)?)

}

// MARK: - IQDialogContainerBackgroundView -

public protocol IQDialogContainerBackgroundView : class {

    var containerViewController: IQDialogContainerViewController? { set get }

    func presentDialog(viewController: IQDialogViewController, isFirst: Bool, animated: Bool)
    func dismissDialog(viewController: IQDialogViewController, isLast: Bool, animated: Bool)

}

// MARK: - IQDialogViewController -

public protocol IQDialogViewController : IQViewController {

    var containerViewController: IQDialogContainerViewController? { get }
    var contentViewController: IQDialogContentViewController { get }
    var widthBehaviour: QDialogViewControllerSizeBehaviour { set get }
    var heightBehaviour: QDialogViewControllerSizeBehaviour { set get }
    var verticalAlignment: QDialogViewControllerVerticalAlignment { set get }
    var horizontalAlignment: QDialogViewControllerHorizontalAlignment { set get }
    var presentAnimation: IQDialogViewControllerFixedAnimation? { get }
    var dismissAnimation: IQDialogViewControllerFixedAnimation? { get }
    var interactiveDismissAnimation: IQDialogViewControllerInteractiveAnimation? { get }

    func dismissDialog(animated: Bool, completion: (() -> Swift.Void)?)

}

public extension IQDialogViewController {

    public var containerViewController: IQDialogContainerViewController? {
        get { return self.parent as? IQDialogContainerViewController }
    }

    public func dismissDialog(animated: Bool, completion: (() -> Swift.Void)?) {
        guard let vc = self.containerViewController else { return }
        vc.dismissDialog(viewController: self, animated: animated, completion: completion)
    }

}

// MARK: - IQDialogContentViewController -

public protocol IQDialogContentViewController : IQViewController {

    var dialogViewController: IQDialogViewController? { get }

    func didPressedOutsideContent()

}

public extension IQDialogContentViewController {

    public var dialogViewController: IQDialogViewController? {
        get { return self.parent as? IQDialogViewController }
    }

}

//
//  Quickly
//

open class QCollectionViewController : QViewController, IQStackContentViewController, IQPageContentViewController {

    #if DEBUG
    open override var logging: Bool {
        get { return true }
    }
    #endif
    public var contentOffset: CGPoint {
        get {
            guard self.isLoaded == true else { return CGPoint.zero }
            let contentOffset = self.collectionView.contentOffset
            let contentInset = self.collectionView.contentInset
            return CGPoint(
                x: contentInset.left + contentOffset.x,
                y: contentInset.top + contentOffset.y
            )
        }
    }
    public var contentSize: CGSize {
        get {
            guard self.isLoaded == true else { return CGSize.zero }
            return self.collectionView.contentSize
        }
    }
    public var collectionController: IQCollectionController? {
        set(value) {
            if let controller = self.collectionView.collectionController {
                controller.removeObserver(self)
            }
            self.collectionView.collectionController = value
            if let controller = self.collectionView.collectionController {
                controller.addObserver(self, priority: 0)
            }
        }
        get {return self.collectionView.collectionController }
    }
    public var refreshControlHidden: Bool = false {
        didSet { self._updateRefreshControlState() }
    }
    public var refreshControl: UIRefreshControl? {
        set(value) {
            if let refreshControl = self.storeRefreshControl {
                if refreshControl.isRefreshing == true {
                    refreshControl.endRefreshing()
                }
            }
            self.storeRefreshControl = value
            self._updateRefreshControlState()
        }
        get { return self.storeRefreshControl }
    }
    public var isRefreshing: Bool {
        get {
            guard let refreshControl = self.storeRefreshControl else { return false }
            return refreshControl.isRefreshing
        }
    }
    private var collectionView: QCollectionView! {
        willSet {
            guard let view = self.collectionView else { return }
            view.removeFromSuperview()
        }
        didSet {
            guard let view = self.collectionView else { return }
            let edgeInsets = self.inheritedEdgeInsets
            view.contentInset = edgeInsets
            view.scrollIndicatorInsets = edgeInsets
            self.view.addSubview(view)
        }
    }
    private var storeRefreshControl: UIRefreshControl? {
        willSet {
            guard let refreshControl = self.storeRefreshControl else { return }
            refreshControl.removeValueChanged(self, action: #selector(self._triggeredRefreshControl(_:)))
        }
        didSet {
            guard let refreshControl = self.storeRefreshControl else { return }
            refreshControl.addValueChanged(self, action: #selector(self._triggeredRefreshControl(_:)))
        }
    }

    open override func didLoad() {
        self.collectionView = QCollectionView(frame: self.view.bounds, layout: QCollectionFlowLayout())
    }

    open override func layout(bounds: CGRect) {
        super.layout(bounds: bounds)
        if let view = self.collectionView {
            view.frame = bounds
        }
    }

    open override func didChangeAdditionalEdgeInsets() {
        super.didChangeAdditionalEdgeInsets()
        if let view = self.collectionView {
            let edgeInsets = self.inheritedEdgeInsets
            view.leftEdgeInset = edgeInsets.left
            view.rightEdgeInset = edgeInsets.right
            view.contentInset = UIEdgeInsets(
                top: edgeInsets.top,
                left: 0,
                bottom: edgeInsets.bottom,
                right: 0
            )
            view.scrollIndicatorInsets = edgeInsets
            view.contentOffset = CGPoint(
                x: -edgeInsets.left,
                y: -edgeInsets.top
            )
        }
    }

    open override func willPresent(animated: Bool) {
        super.willPresent(animated: animated)
        self._updateRefreshControlState()
    }

    open override func didDismiss(animated: Bool) {
        super.didDismiss(animated: animated)
        self._updateRefreshControlState()
    }
    
    open override func willTransition(size: CGSize) {
        super.willTransition(size: size)
        if let collectionLayout = self.collectionView.collectionLayout {
            collectionLayout.invalidateLayout()
        }
    }

    open func beginRefreshing() {
        guard let refreshControl = self.storeRefreshControl else { return }
        refreshControl.beginRefreshing()
    }

    open func endRefreshing() {
        guard let refreshControl = self.storeRefreshControl else { return }
        refreshControl.endRefreshing()
    }

    open func triggeredRefreshControl() {
    }

    @objc
    private func _triggeredRefreshControl(_ sender: Any) {
        self.triggeredRefreshControl()
    }

    private func _updateRefreshControlState() {
        if self.isLoaded == true {
            if self.refreshControlHidden == false && self.isPresented == true {
                self.collectionView.refreshControl = self.storeRefreshControl
            } else {
                if let refreshControl = self.storeRefreshControl {
                    refreshControl.endRefreshing()
                }
                self.collectionView.refreshControl = nil
            }
        }
    }

}

extension QCollectionViewController : IQCollectionControllerObserver {

    open func scroll(_ controller: IQCollectionController, collectionView: UICollectionView) {
        if let vc = self.contentOwnerViewController {
            vc.updateContent()
        }
    }

    open func zoom(_ controller: IQCollectionController, collectionView: UICollectionView) {
        if let vc = self.contentOwnerViewController {
            vc.updateContent()
        }
    }

    open func update(_ controller: IQCollectionController) {
    }

}

//
//  Quickly
//

open class QTableView : UITableView, IQView {

    public var tableController: IQTableController? {
        willSet {
            self.delegate = nil
            self.dataSource = nil
            if let tableController = self.tableController {
                tableController.tableView = nil
            }
        }
        didSet {
            self.delegate = self.tableController
            self.dataSource = self.tableController
            if let tableController = self.tableController {
                tableController.tableView = self
            }
        }
    }
    open override var refreshControl: UIRefreshControl? {
        set(value) {
            if #available(iOS 10, *) {
                super.refreshControl = value
            } else {
                self.legacyRefreshControl = value
            }
        }
        get {
            if #available(iOS 10, *) {
                return super.refreshControl
            } else {
                return self.legacyRefreshControl
            }
        }
    }
    open var contentLeftInset: CGFloat = 0
    open var contentRightInset: CGFloat = 0

    private var legacyRefreshControl: UIRefreshControl? {
        willSet {
            guard let refreshControl = self.legacyRefreshControl else { return }
            self.addSubview(refreshControl)
        }
        didSet {
            guard let refreshControl = self.legacyRefreshControl else { return }
            refreshControl.removeFromSuperview()
        }
    }

    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    open func setup() {
        self.backgroundColor = UIColor.clear
        
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
            self.insetsContentViewsToSafeArea = false
        }
    }

}

extension QTableView : IQContainerSpec {
    
    open var containerSize: CGSize {
        get { return UIEdgeInsetsInsetRect(self.bounds, self.contentInset).size }
    }
    open var containerLeftInset: CGFloat {
        get { return self.contentLeftInset }
    }
    open var containerRightInset: CGFloat {
        get { return self.contentRightInset }
    }
    
}

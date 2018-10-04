//
//  Quickly
//

public protocol IQTableDecorDelegate : class {
}

public protocol IQTableDecor : IQTableReuse {

    typealias Dequeue = UITableViewHeaderFooterView & IQTableDecor

    var tableDelegate: IQTableDecorDelegate? { set get }

    static func dequeue(tableView: UITableView) -> Dequeue?

    func configure()

    func set(any: Any, spec: IQContainerSpec, animated: Bool)

}

extension IQTableDecor where Self : UITableViewHeaderFooterView {

    public static func register(tableView: UITableView) {
        if let nib = self.currentNib() {
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: self.reuseIdentifier())
        } else {
            tableView.register(self.classForCoder(), forHeaderFooterViewReuseIdentifier: self.reuseIdentifier())
        }
    }

    public static func dequeue(tableView: UITableView) -> Dequeue? {
        return tableView.dequeueReusableHeaderFooterView(
            withIdentifier: self.reuseIdentifier()
        ) as? Dequeue
    }

}

public protocol IQTypedTableDecor : IQTableDecor {

    associatedtype DataType: IQTableData

    static func height(data: DataType, spec: IQContainerSpec) -> CGFloat

    func set(data: DataType, spec: IQContainerSpec, animated: Bool)

}

extension IQTypedTableDecor {

    public static func using(any: Any) -> Bool {
        return any is DataType
    }

    public static func usingLevel(any: AnyClass) -> UInt? {
        return inheritanceLevel(any, DataType.self)
    }

    public static func height(any: Any, spec: IQContainerSpec) -> CGFloat {
        return self.height(data: any as! DataType, spec: spec)
    }

    public func set(any: Any, spec: IQContainerSpec, animated: Bool) {
        self.set(data: any as! DataType, spec: spec, animated: animated)
    }

}

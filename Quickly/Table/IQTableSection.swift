//
//  Quickly
//

public protocol IQTableSection : class {

    var controller: IQTableController? { get }
    var index: Int? { get }
    var canEdit: Bool { get }
    var canMove: Bool { get }
    var hidden: Bool { get }

    var header: IQTableData? { set get }
    var footer: IQTableData? { set get }
    var rows: [IQTableRow] { get }

    func bind(_ controller: IQTableController, _ index: Int)
    func rebind(_ index: Int)
    func unbind()
    
    func setRows(_ rows: [IQTableRow])

    func prependRow(_ row: IQTableRow, with animation: UITableView.RowAnimation?)
    func prependRow(_ rows: [IQTableRow], with animation: UITableView.RowAnimation?)
    func appendRow(_ row: IQTableRow, with animation: UITableView.RowAnimation?)
    func appendRow(_ rows: [IQTableRow], with animation: UITableView.RowAnimation?)
    func insertRow(_ row: IQTableRow, index: Int, with animation: UITableView.RowAnimation?)
    func insertRow(_ rows: [IQTableRow], index: Int, with animation: UITableView.RowAnimation?)
    func deleteRow(_ row: IQTableRow, with animation: UITableView.RowAnimation?)
    func deleteRow(_ rows: [IQTableRow], with animation: UITableView.RowAnimation?)
    func reloadRow(_ row: IQTableRow, with animation: UITableView.RowAnimation?)
    func reloadRow(_ rows: [IQTableRow], with animation: UITableView.RowAnimation?)

    func moveRow(_ fromRow: IQTableRow, toIndex: Int) -> Bool
    func moveRow(_ fromIndex: Int, toIndex: Int)

}

public extension IQTableSection {

    public func prependRow(_ row: IQTableRow, with animation: UITableView.RowAnimation? = nil) {
        self.insertRow([ row ], index: self.rows.startIndex, with: animation)
    }

    public func prependRow(_ rows: [IQTableRow], with animation: UITableView.RowAnimation? = nil) {
        self.insertRow(rows, index: self.rows.startIndex, with: animation)
    }

    public func appendRow(_ row: IQTableRow, with animation: UITableView.RowAnimation? = nil) {
        self.insertRow([ row ], index: self.rows.endIndex, with: animation)
    }

    public func appendRow(_ rows: [IQTableRow], with animation: UITableView.RowAnimation? = nil) {
        self.insertRow(rows, index: self.rows.endIndex, with: animation)
    }

    public func insertRow(_ row: IQTableRow, index: Int, with animation: UITableView.RowAnimation? = nil) {
        self.insertRow([ row ], index: index, with: animation)
    }

    public func deleteRow(_ row: IQTableRow, with animation: UITableView.RowAnimation? = nil) {
        self.deleteRow([ row ], with: animation)
    }

    public func reloadRow(_ row: IQTableRow, with animation: UITableView.RowAnimation? = nil) {
        self.reloadRow([ row ], with: animation)
    }

    public func moveRow(_ fromRow: IQTableRow, toIndex: Int) -> Bool {
        guard let fromIndex = self.rows.index(where: { return ($0 === fromRow) }) else { return false }
        self.moveRow(fromIndex, toIndex: toIndex)
        return true
    }

}

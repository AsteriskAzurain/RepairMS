//-----------
// [root@asterisk bingweifang]# mongoimport -d repairingInfoMS -c param_tmp --type csv --headerline --file /data/MSSQLData/paramTable.csv 
// 2021-05-21T02:26:33.083+0800	connected to: localhost
// 2021-05-21T02:26:33.103+0800	imported 13 documents
// [root@asterisk bingweifang]# mongoimport -d repairingInfoMS -c employee_tmp --type csv --headerline --file /data/MSSQLData/employeeTable.csv 
// 2021-05-21T02:26:42.267+0800	connected to: localhost
// 2021-05-21T02:26:42.289+0800	imported 1 document
// [root@asterisk bingweifang]# mongoimport -d repairingInfoMS -c repairman_tmp --type csv --headerline --file /data/MSSQLData/repairmanTable.csv 
// 2021-05-21T02:26:55.438+0800	connected to: localhost
// 2021-05-21T02:26:55.465+0800	imported 27 documents
// [root@asterisk bingweifang]# mongoimport -d repairingInfoMS -c project_tmp --type csv --headerline --file /data/MSSQLData/projectTable.csv 
// 2021-05-21T02:27:04.263+0800	connected to: localhost
// 2021-05-21T02:27:04.284+0800	imported 13 documents
// [root@asterisk bingweifang]# mongoimport -d repairingInfoMS -c projectDetail_tmp --type csv --headerline --file /data/MSSQLData/projectDetailTable_1.csv 
// 2021-05-21T02:27:12.331+0800	connected to: localhost
// 2021-05-21T02:27:12.356+0800	imported 22 documents
// [root@asterisk bingweifang]# cp MSSQLData/paramTable_1.csv /data/MSSQLData/
// [root@asterisk bingweifang]# mongoimport -d repairingInfoMS -c param_tmp --type csv --headerline --file /data/MSSQLData/paramTable_1.csv 
// 2021-05-21T02:31:14.910+0800	connected to: localhost
// 2021-05-21T02:31:14.935+0800	imported 13 documents
// [root@asterisk bingweifang]# 
//-----------

db.param_tmp.find().forEach(function (document) {
    var key = document.paramID
    document._id = key
    db.param.insert(document)
    db.param.update({ _id: key }, { $unset: { paramID: '' } })
})

db.employee_tmp.find().forEach(function (document) {
    var key = document.employeeID
    document._id = key
    db.employee.insert(document)
    db.employee.update({ _id: key }, { $unset: { employeeID: '' } })
})

db.repairman_tmp.find().forEach(function (document) {
    var key = document.repairmanID
    document._id = key
    db.repairman.insert(document)
    db.repairman.update({ _id: key }, { $unset: { repairmanID: '' } })
})

db.project_tmp.find().forEach(function (document) {
    var key = document.projectID
    document._id = key
    db.project.insert(document)
    db.project.update({ _id: key }, { $unset: { projectID: '' } })
})

db.projectDetail_tmp.find().forEach(function (document) {
    var key = document.detailID
    document._id = key
    db.projectDetail.insert(document)
    db.projectDetail.update({ _id: key }, { $unset: { detailID: '' } })
})

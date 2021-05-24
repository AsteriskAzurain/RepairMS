// ** Id -> _id **

db.project.insert([
        { _id: 1, projectStatus: 1, priority: 2, projectType: 2, projectSite: 1, contactName: 'update', contactPhone: '13811111111', projectDetail: '投影坏了。', siteDetail: '图文315', hasDetail: 1, createDate: ISODate('2021-02-02T23:53:25Z'), updateDate: ISODate('2021-02-07T09:25:59Z'), deleteStatus: 1 },
        { _id: 2, projectStatus: 2, priority: 0, projectType: 3, projectSite: 2, contactName: 'Chapman', contactPhone: '13901201007', projectDetail: '空调温度太低。', siteDetail: '10#529', hasDetail: 1, createDate: ISODate('2021-02-02T23:56:21Z'), updateDate: ISODate('2021-02-08T00:49:50Z'), deleteStatus: 1 },
        { _id: 3, projectStatus: 1, priority: 1, projectType: 1, projectSite: 1, contactName: 'Scott', contactPhone: '13902100917', projectDetail: '无法投屏。', siteDetail: '图文319', hasDetail: 1, createDate: ISODate('2021-02-02T23:58:44Z'), updateDate: ISODate('2021-02-08T00:48:39Z'), deleteStatus: 1 },
        { _id: 4, projectStatus: 1, priority: 0, projectType: 3, projectSite: 1, contactName: 'Michelle', contactPhone: '13811011023', projectDetail: '桌子腿断了。', siteDetail: '4#518', hasDetail: 1, createDate: ISODate('2021-02-03T00:02:04Z'), updateDate: ISODate('2021-02-07T09:26:12Z'), deleteStatus: 1 },
        { _id: 5, projectStatus: 1, priority: 0, projectType: 1, projectSite: 1, contactName: 'Gavin', contactPhone: '18915203090', projectDetail: '电脑蓝屏。', siteDetail: '2#210', hasDetail: 1, createDate: ISODate('2021-02-03T02:48:06Z'), updateDate: ISODate('2021-02-08T01:17:00Z'), deleteStatus: 1 },
        { _id: 6, projectStatus: 1, priority: 2, projectType: 3, projectSite: 3, contactName: 'Vivian', contactPhone: '13743902418', projectDetail: '饮水机漏水。', siteDetail: '10#317', hasDetail: 1, createDate: ISODate('2021-02-03T03:25:56Z'), updateDate: ISODate('2021-02-08T00:49:48Z'), deleteStatus: 1 },
        { _id: 7, projectStatus: 3, priority: 0, projectType: 2, projectSite: 1, contactName: '', contactPhone: '13959281514', projectDetail: '教室顶灯时明时暗', siteDetail: '4#418', hasDetail: 1, createDate: ISODate('2021-02-07T06:09:35Z'), updateDate: ISODate('2021-02-10T02:39:00Z'), deleteStatus: 1 },
        { _id: 8, projectStatus: 1, priority: 0, projectType: 1, projectSite: 2, contactName: '王测', contactPhone: '18910015019', projectDetail: '电脑连不上校园网SBS', siteDetail: '9#216', hasDetail: 1, createDate: ISODate('2021-02-07T08:00:42Z'), updateDate: ISODate('2021-02-08T01:07:45Z'), deleteStatus: 1 },
        { _id: 9, projectStatus: 1, priority: 0, projectType: 2, projectSite: 1, contactName: '王试', contactPhone: '17702165918', projectDetail: '单杠松动', siteDetail: '健身房', hasDetail: 1, createDate: ISODate('2021-02-07T08:02:17Z'), updateDate: ISODate('1900-01-00T00:00:00Z'), deleteStatus: 1 },
        { _id: 10, projectStatus: 0, priority: 1, projectType: 3, projectSite: 2, contactName: 'Bernard', contactPhone: '17725514923', projectDetail: '寝室连不上网', siteDetail: '10#523', hasDetail: 0, createDate: ISODate('2021-02-10T00:25:57Z'), updateDate: ISODate('2021-02-12T02:06:33Z'), deleteStatus: 1 },
        { _id: 11, projectStatus: 1, priority: 1, projectType: 2, projectSite: 1, contactName: 'Ruby', contactPhone: '15902860197', projectDetail: '投影亮度不够，还有色偏。', siteDetail: '2#317', hasDetail: 1, createDate: ISODate('2021-02-10T02:37:27Z'), updateDate: ISODate('2021-02-12T02:04:49Z'), deleteStatus: 1 },
        { _id: 12, projectStatus: 0, priority: 2, projectType: 3, projectSite: 2, contactName: 'Colin', contactPhone: '1927715543', projectDetail: '在哪里可以买到寝室路由器呢', siteDetail: '10#428', hasDetail: 0, createDate: ISODate('2021-02-10T03:01:51Z'), updateDate: ISODate('1900-01-00T00:00:00Z'), deleteStatus: 1 }

    ])
    /* BulkWriteResult({
    	"writeErrors" : [ ],
    	"writeConcernErrors" : [ ],
    	"nInserted" : 12,
    	"nUpserted" : 0,
    	"nMatched" : 0,
    	"nModified" : 0,
    	"nRemoved" : 0,
    	"upserted" : [ ]
    }) */

// ="{"&"projectID:"&A2&","&"projectStatus:"&B2&","&"priority:"&C2&","&"projectType:"&D2&","&"projectSite:"&E2&","&"contactName:'"&F2&"',"&"contactPhone:'"&G2&"',"&"projectDetail:'"&H2&"',"&"siteDetail:'"&I2&"',"&"hasDetail:"&J2&","&"createDate:ISODate('"&TEXT(K2,"yyyy-mm-ddThh:mm:ssZ")&"'),"&"updateDate:ISODate('"&TEXT(L2,"yyyy-mm-ddThh:mm:ssZ")&"'),"&"deleteStatus:"&M2&"}"
// >>> colList="..."
// >>> colList=colList.split(',')
// >>> alphaList='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
// >>> fmtstr="&\"{0}:\"&{1}2&\",\""
// >>> mystr=""
// >>> for i in range(len(colList)):
// mystr+=(fmtstr.format(colList[i],alphaList[i]))
// >>> print('"{"'+mystr)

db.projectDetail.insert([
        { detailID: 1, projectID: 1, repairmanID: 1, severity: 1, faultType: 1, faultStatus: 1, faultDetail: 'detail desc.', add_requirement: '', createDate: ISODate('2021-02-03T00:59:20Z'), updateDate: ISODate('2021-02-03T02:48:32Z'), deleteStatus: 1 },
        { detailID: 2, projectID: 1, repairmanID: 9, severity: 2, faultType: 2, faultStatus: 0, faultDetail: 'detail desc.', createDate: ISODate('2021-02-03T01:01:44Z'), updateDate: ISODate('2021-02-05T05:18:49Z'), deleteStatus: 1 },
        { detailID: 15, projectID: 3, repairmanID: 1, severity: 1, faultType: 1, faultStatus: 2, faultDetail: 'detail desc.', createDate: ISODate('2021-02-05T02:52:56Z'), deleteStatus: 1 },
        { detailID: 16, projectID: 4, repairmanID: 4, severity: 3, faultType: 1, faultStatus: 2, faultDetail: 'detail desc.', createDate: ISODate('2021-02-05T02:53:57Z'), deleteStatus: 1 },
        { detailID: 17, projectID: 2, repairmanID: 9, severity: 2, faultType: 2, faultStatus: 2, faultDetail: 'detail desc.', createDate: ISODate('2021-02-05T02:56:02Z'), deleteStatus: 1 },
        { detailID: 18, projectID: 5, repairmanID: 4, severity: 1, faultType: 2, faultStatus: 1, faultDetail: 'detail desc.', add_requirement: 'update', createDate: ISODate('2021-02-05T02:58:19Z'), updateDate: ISODate('2021-02-12T03:33:52Z'), deleteStatus: 1 },
        { detailID: 19, projectID: 6, repairmanID: 1, severity: 1, faultType: 1, faultStatus: 0, faultDetail: 'detail desc.', createDate: ISODate('2021-02-05T03:13:23Z'), updateDate: ISODate('2021-02-05T03:34:28Z'), deleteStatus: 1 },
        { detailID: 20, projectID: 2, repairmanID: 3, severity: 2, faultType: 1, faultStatus: 0, faultDetail: 'detail desc.', createDate: ISODate('2021-02-05T03:13:31Z'), updateDate: ISODate('2021-02-05T03:34:27Z'), deleteStatus: 1 },
        { detailID: 21, projectID: 6, repairmanID: 14, severity: 0, faultType: 0, faultStatus: 2, faultDetail: 'detail desc.', createDate: ISODate('2021-02-05T05:15:05Z'), deleteStatus: 1 },
        { detailID: 22, projectID: 1, repairmanID: 20, severity: 0, faultType: 0, faultStatus: 0, faultDetail: 'detail desc.', createDate: ISODate('2021-02-05T05:18:47Z'), updateDate: ISODate('2021-02-05T05:20:50Z'), deleteStatus: 0 },
        { detailID: 23, projectID: 5, repairmanID: 13, severity: 0, faultType: 0, faultStatus: 2, faultDetail: 'detail desc.', createDate: ISODate('2021-02-05T05:34:34Z'), deleteStatus: 1 },
        { detailID: 24, projectID: 7, repairmanID: 2, severity: 0, faultType: 0, faultStatus: 2, faultDetail: 'detail desc.', add_requirement: 'update', createDate: ISODate('2021-02-08T00:42:44Z'), updateDate: ISODate('2021-02-12T03:35:12Z'), deleteStatus: 1 },
        { detailID: 25, projectID: 7, repairmanID: 3, severity: 0, faultType: 0, faultStatus: 2, faultDetail: 'detail desc.', createDate: ISODate('2021-02-08T00:43:59Z'), deleteStatus: 1 },
        { detailID: 26, projectID: 9, repairmanID: 7, severity: 0, faultType: 0, faultStatus: 2, faultDetail: 'detail desc.', createDate: ISODate('2021-02-10T00:44:00Z'), deleteStatus: 1 },
        { detailID: 27, projectID: 8, repairmanID: 20, severity: 0, faultType: 0, faultStatus: 2, faultDetail: 'detail desc.', createDate: ISODate('2021-02-10T02:39:00Z'), deleteStatus: 1 },
        { detailID: 28, projectID: 11, repairmanID: 12, severity: 0, faultType: 0, faultStatus: 2, faultDetail: 'detail desc.', createDate: ISODate('2021-02-10T03:58:47Z'), deleteStatus: 1 }
    ])
    /*
    BulkWriteResult({
    	"writeErrors" : [ ],
    	"writeConcernErrors" : [ ],
    	"nInserted" : 16,
    	"nUpserted" : 0,
    	"nMatched" : 0,
    	"nModified" : 0,
    	"nRemoved" : 0,
    	"upserted" : [ ]
    })
    */
	
	//="{"&"detailID:"&A2&","&"projectID:"&B2&","&"repairmanID:"&C2&","&"severity:"&D2&","&"faultType:"&E2&","&"faultStatus:"&F2&","&"faultDetail:'"&G2&"',"&"add_requirement:"&H2&","&"createDate:ISODate('"&TEXT(I2,"yyyy-mm-ddThh:mm:ssZ")&"'),"&"updateDate:ISODate('"&TEXT(J2,"yyyy-mm-ddThh:mm:ssZ")&"'),"&"deleteStatus:"&K2&"}"
	
	
db.getCollection("repairPhotos.files").update({},{$set:{"metadata.detailID":24}},{multi:true})

)
var metadata={
        "detailID" :  NumberInt(24), 
        "uploadUser" : {
            "role" : NumberInt(1), 
            "user" : NumberInt(1)
        }, 
        "deleteStatus" : NumberInt(1)
    }
printjson(metadata)
db.getCollection("repairPhotos.files").update({},{$set:{"metadata":metadata}},{multi:true})
# RepairMS

- [x] 报修form（新增+查询）
- [x] 登录页 多角色
- [x] 项目细节页
- [x] 维修细节页
- [ ] Master
- 管理

  - [x] 待分配
  - [x] 待处理
  - [x] 完成项目查询
  - [x] 维修人员管理
  - [ ] 维修人员详情页
  - [ ] ~~汇总页~~
- 维修

  - [ ] 待处理
  - [ ] 已完成

---

### 需求

#### 管理

##### 1. 待分配报修

  - [x] 条件查询
      * ID、优先级、报修类型、报修地点、~~联系人姓名~~
  - [x] 查看/修改报修项目信息（~~顶部btn~~ <u>`View`</u>）
  - [x] Grid_Row 显示 已分配/未分配 | 分配人员
  - [x] cmb维修人员，分配维修人员 => 创建detail记录 => Status=1
      - [x]  未分配 → 分配+创建detail
      - 已分配 → 更新+创建/更新detail
        -  ❓允许多选
      -  Grid设计：
         -  ❌下拉框
         - [x]  左右Grid 中间btn：Assign
         - [x]  维修人员Grid ~~❓添加textBox筛选~~
         -  此页面（Status=0）→ 更新detail

##### 2. 待跟进报修

  - [x] 查询，查看详细信息
  - [x] 查看detail信息
  - [x] 添加报修人员 => 添加detail（Status=2）
    * [x] 添加时，check人名
  - [x] 上下Grid，下Grid查询Detail，可添加
  - [x] Row末尾 btn结项，设置项目为已完成

> TODO： 
>
> - [x] projectStatus selectChange事件(+confirm); 
> - [x] View * 2; 
> - [x] GetAllRepairMan order by name asc; 
> - [x] 添加proj查询
> - [ ] proj Sort; 
> - [ ] 完善param表;
> - [x] 重名check.

##### 3. 完成报修查询

- [x] 查找
- [ ] ~~可折叠，展开查看详情~~
- [x] Row末尾 btn详情 | btnDetail

##### 4. 维修人员管理

- [x] 查找
- [x] 添加、删除/恢复
  - [x] 重名check
- [x] Grid (All Info)
- [ ] 修改信息



#### 维修

##### 1. 我的项目

- [ ] 查找（Card）
- [ ] btn详情
- [ ] btn填写维修详情
- [ ] 调整状态（待处理、待跟进、已完成）

历史项目？

修改密码？


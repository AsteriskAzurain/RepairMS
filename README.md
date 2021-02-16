# RepairMS

- [x] 报修form（新增+查询）
- [x] 登录页 多角色
- [x] 项目细节页
- [x] 维修细节页
- [x] Master
- 管理

  - [x] 待分配
  - [x] 待处理
  - [x] 完成项目查询
  - [x] 维修人员管理
  - [ ] 维修人员详情页
  - [ ] ~~汇总页~~
- 维修

  - [x] 待处理
  - [x] 已完成

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

- [x] 查找（Card）
- [x] btn详情
- [x] btn填写维修详情
- [x] 调整状态（待处理、待跟进、已完成）

历史项目？

修改密码？

> **报修类型、报修地点、优先级**
>
> *createDate*
>
> * 联系人姓名、手机号
> * 保修地点+具体位置
> * 详细描述
>
> `cmbUpdStatus`
>
> `btnViewProj` `btnFillDetail`



##### 0214 TODO:

1. - [x] `rm待处理页`标题;

2. - [x] 查找功能;

3. ~~历史项目?~~ ;

4. ~~`projectStatus` 切成 `finished`时 无confirm?~~ ;

5. ~~无权限时显示~~ (跳转至`Login`);

6. - [x] 其他页权限判断（在`master`中完成?）;

7. - [x] `Login页` 登陆成功跳转;

8. ~~`Login页` 记住密码?~~ ;

9. `rmManage页` 详情页? 修改信息? ;

10. - [x] 其他页`cmbProjectStatus`重新绑定+添加css;

    1. AssignProject
    2. RepairProject
    
    ```css
    .xxcontainer .xxHovered { background-color: #F0F0F0; }
    .xxcontainer .xxDisabled:hover { cursor: no-drop; }
    ```


11. - [x] master（✔①设计, ✔②验证session. ）;
12. ~~web.config - login - 设置路径~~ 已在master中验证;
13. - [x] 页面ajax;
14. ~~tooltip~~;
15. `RepairDetailPage` 根据loginUser判断冻结的input;
16. ~~修改dao层 string的判空->string.IsNullOrEmpty(mystr)~~;
17. ~~`已分配项目页` 选中rm, 允许更新proj's rm?~~
18. detail表操作时，同步更新faultType;
19. - [x] detailLIst -> detailList
20. ~~在`itemDataBound`方法中 给`GridHyperlinkColumn`赋值?~~
21. - [x] `rm待处理页`添加其他状态（待跟进、已完成）;
22. 待补充.


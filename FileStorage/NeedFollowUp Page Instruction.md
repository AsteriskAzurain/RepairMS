## Overview

[![cvLiLj.png](https://z3.ax1x.com/2021/04/25/cvLiLj.png)](https://imgtu.com/i/cvLiLj)


## Code

### Frontend
[![cvLAwn.png](https://z3.ax1x.com/2021/04/25/cvLAwn.png)](https://imgtu.com/i/cvLAwn)

### Backend
[![cvLEoq.jpg](https://z3.ax1x.com/2021/04/25/cvLEoq.jpg)](https://imgtu.com/i/cvLEoq)



## Key Points

* <font color='red'>ASP.NET生命周期</font>
* <font color='red'>ViewState</font>
* <font color='red'>逻辑删除</font>
* <font color='red'>`<telerik:RadAjaxManager>`</font>



## Details

1.  ASP.NET WebForm生命周期

    参考链接：[Asp.Net WebForm生命周期的详解](https://www.cnblogs.com/hgmyz/p/7006964.html)

    ![](http://mmbiz.qpic.cn/mmbiz_jpg/6OxqSqWBqsKNb4ydDlRZQ6ia483FqcaEQKiaaGjsmCMdgW3wnoHbjqeicU1icYxNQc91hXre1M2P665bFOXatoocbQ/0?wx_fmt=jpeg)
    
2.  ViewState

    > ViewState是一个名称/值的对象集合。当请求某个页面时，ASP.NET会把所有控件的状态序列化成一个字符串，然后作为窗体的隐藏属性送到客户端，当客户端把页面回传时，ASP.NET分析回传的窗体属性，并赋给控件对应的值。

    ViewState在ASP.NET框架的项目下用的相当频繁，可以简单的存储页面上的数据、状态等，存取以键值对的方式实现，极为方便，一般取出前需要先判空。
    
3. telerik实现ajax的方法：`<telerik:RadAjaxManager>`

   *   ajax：

       >   AJAX = Asynchronous JavaScript and XML（异步的 JavaScript 和 XML）。
       >
       >   AJAX 不是新的编程语言，而是一种使用现有标准的新方法。
       >
       >   AJAX 是与服务器交换数据并更新部分网页的艺术，在不重新加载整个页面的情况下。

       ajax在浏览器(user端)与后端之间使用异步数据传输，传统的浏览器与服务端交互的方式使用表单数据提交的方式，任何需要服务端对用户动作提供反馈的请求都需要重新刷新用户的界面，伤害用户的使用体验，使用ajax使用异步刷新对服务端进行请求，可以在不刷新(重载)页面的情况下，完成对页面局部数据的刷新。

       参考链接：[telerik官方文档：What is AJAX?](https://docs.telerik.com/devtools/aspnet-ajax/controls/ajaxmanager/getting-started/what-is-ajax)

       >   传统方式的缺点：
       >
       >   *   Poor Interactivity 交互性差 - 用户与应用程序的每次交互都会被postback打断（点一下页面刷新一下的感觉）。
       >   *   Ineffectiveness 低效 - 每次postback回来，页面都会重新渲染(postback->server处理数据->请求成功后,server发送新页面到browser->browser再次渲染页面)。
       >   *   Low Usability 低可用性 - 整页postback的技术限制了页面的复杂程度（包括功能、用户体验...）
       >
       >   ![the complete lifecycle of an AJAX-enabled web form](https://docs.telerik.com/devtools/aspnet-ajax/controls/ajaxmanager/getting-started/images/AJAX_diagram_thumb.gif)

       

   *   ajax with telerik：

       一般来说，简单的ajax实现是通过书写js代码，telerik封装并提供了简单的配置面板控件来提供ajax实现，可以轻松的在配置面板打勾来代替写代码✔。
       
       telerik官方文档描述的优点：
       
       >   -   AJAX-enable any existing or new application, regardless of its level of complexity - 在页面加上`<telerik:RadAjaxManager>`就能在页面使用ajax，是telerik项目就支持。
       >   -   You don't need detailed knowledge of AJAX - 不需要coder了解ajax，配置面板完全傻瓜操作
       >   -   You don't have to modify your application - you do not need to place Update Panels, set triggers, manually invoke AJAX requests, etc. - 对自己写的代码没影响（还是有影响的，对受控的前端控件的style/display属性有影响，因为其控制控件的时候，会在控件外层添加一层ajax控制的块div，此div自带的一些属性可能会影响页面布局）
       >   -   You don't have to write a single line of code (JavaScript or server-side) - codeless操作

4. 前端Line2

   *   `<telerik:RadGrid>`标签封装了ASP.NET-WebForm服务器控件`<asp:GridView>`，

       主要用于展示系统各类数据，支持codeless的绑定数据、新增/编辑数据、分页、排序、筛选、导出等功能，基本可以通过使用telerik ajax扩展提供的配置面板完成设置。

   *   官方介绍：

       >   Robust ASP.NET AJAX Grid component for flawless data visualization. Supporting codeless data binding, paging, sorting, filtering, export and many more features. 

       > **Insert, Update, Delete with Various Edit Modes and Edit Forms**
       > You can enable automatic data editing for RadGrid when it’s bound to a DataSource control like SqlDataSource, LinqDataSource, EntityDataSource, etc. or use the extensive API to handle the CRUD operations in a custom manner. Display the edit form inline, as a regular form or in a popup and choose between the built-in edit forms, your own template or a user control. Enable batch editing to allow users to edit multiple items and save them all by hitting the Save button just once.

5. 前端Line3

   *   `AutoGenerateColumns="False"`：

       默认值为True，根据Grid的DataSource属性值自动生成数据展示的列；

       设为False，则可以在Grid的telerik扩展配置面板中“Edit Columns”，即在`<Columns>`下设置要展示的列及其样式，一般展示数据库的数据会用`<telerik:GridBoundColumn>`，`<Columns>`下的所有列，如果有“DataField”属性（如line11），则这里填的必须是有效值（数据源里必须要有这一列，不然会报错）。

   *   `AutoGenerateDeleteColumn="True"`：

       telerik Grid支持很多不需要写代码的功能，就比如这个自动生成删除列，

       设为True后，就会在Grid的最后一列后面加一列删除列，在页面点击删除列的❌，页面上的这行就会消失，但刷新就又回来了，因为默认的codeless方法内不会自己操作数据库，可以使用`GridDetail_ItemCommand() + if(e.CommandName==Delete)`和`GridDetail_DeleteCommand()`来捕捉用户的删除操作，在方法体内调用BLL方法就可以实际删除数据(set DeleteStatus=0)。

6. 前端Line4

   参考链接：[RadGrid Event sequence](https://docs.telerik.com/devtools/aspnet-ajax/controls/grid/control-lifecycle/event-sequence)
   

   > * 初次加载
   >   1. Page.Load
   >   2. Grid_Instance.**NeedDataSource**
   >   3. ItemCreated for each item
   >   4. **ItemDataBound** for each item
   >   5. Page.PreRender
   > * Normal Postback
   >   1. ItemCreated for each item
   >   2. Page.Load
   >   3. Postback Events
   >   4. Page.PreRender
   > * 有编辑数据操作的Postback
   >   1. ItemCreated for each item
   >   2. Page.Load
   >   3. Grid_Instance.ItemCommand
   >   4. Grid_Instance.EditCommand/UpdateCommand/InsertCommand/**DeleteCommand** or GridInstance.PageIndexChanged/SortCommand/GroupsChanging/**ItemCommand**
   >   5. Grid_Instance.**NeedDataSource**
   >   6. ItemCreated for each item
   >   7. **ItemDataBound** for each item
   >   8. Page.PreRender

   line4的意思是为当前Grid添加四个事件，按照文档，这四个事件的顺序是：

   OnItemCommand -> OnDeleteCommand -> OnNeedDataSource -> OnItemDataBound

   <small>为控件添加事件的方法：在vs中，在aspx文件的设计界面，点击需要添加事件的控件，在属性面板（一般是右下角，如没有，可在菜单栏-视图界面找到并打开），点击面板上方的闪电符号，vs会列出此控件所有可以注册的事件，点击任意事件名字右侧的文本框，回车，就可以跳转到后端(*.aspx.cs)界面的对应事件处编辑此事件的代码。</small>

7. 前端Line5

   `EnablePostBackOnRowClick="False"`：后端要处理前端用户的请求，必须要将前端用户的请求postback，没有Postback页面就不会响应任何操作，这个Grid设为False是因为没有需要处理单行数据的需求。

   设为True的时候，就比如此页(RepairProject.aspx/Line163)，就有处理单行数据的需求，具体是指：点击一个项目时，需要为此项目，在下方的Grid中加载出此项目下的所有维修员信息，此时设置上方Grid的此属性，意思就是，当点击Grid当中的某一行的时候，发送一个PostBack请求到后端，触发后端的`GridProject_SelectedIndexChanged()`（RepairProject.aspx.cs/Line56），“SelectedIndexChanged”可以理解为此Grid的选中行改变了，这时候获取此Grid的当前选中行，再获取此行的Project ID，根据ProId去查此项目的维修人员，查到后赋给GridDetail，就可以实现上述功能（点击一个项目，在下方加载出此项目下的所有维修员信息）。

8. 前端Line5-8

   `ClientSettings`下的其他属性，都是为了用户体验or美观考虑而设置的，不影响功能。

   比如`EnableRowHoverStyle="True"`，就是为了用户在鼠标滑过Grid的时候，每一行都有鼠标经过动作；

   `AllowRowSelect="True"`，是为了用户点击Grid当中的某行的时候，Grid会显示选中了某行，不会显得没反应，当然这个属性在与``EnablePostBackOnRowClick`属性搭配时是很有意义的（考虑第7点描述的需求场景）。

   为了用户体验而设置这些项，是为了构建现代化网站时提升用户体验的顺手而为之，不设也无伤大雅（不影响功能），不过一般网站建设还是需要考虑尊重用户的浏览、使用体验的。

9. 前端Line9

   `DataKeyNames="detailID"`：这个属性的值一般填写此Grid数据源的主键PrimaryKey，不写也不碍事，写了可以通过`GridDataItem.GetDataKeyValue("detailID")`直接取到该行主键的值（如：RepairProject.aspx.cs/Line150）；不写的话，也可以通过``GridDataItem["detailID"].Text`取到该行detailID的值，这种方法可以取到该行任意列的值，前提是先设置数据列的`UniqueName`(前端Line12)，如`UniqueName`的属性名，每一列的`UniqueName`都要是唯一的。

   `CommandItemDisplay="Top"`：如前文第3点所述，telerik的RadGrid支持一些codeless的添删改查，这个属性可以用来设置Grid "菜单栏"的显示与否，默认是不显示的，此处设置为"Top"，即为将菜单栏显示，并显示在顶部，并可以在`CommandItemSettings`(前端Line10)中具体设置菜单栏。

   如前端Line10所示，`ShowAddNewRecordButton="True"`，就是开启Grid自带的添加新记录功能，`AddNewRecordText="分配新维修员"`，就是这个添加功能的按钮上的文字显示成"分配新维修员"；`ShowRefreshButton="False"`，则是开启了Grid的菜单栏功能后，刷新按钮是默认开启的，显示在菜单栏右侧，由于没有这个需求，所以将此功能关闭。

   `EditMode="PopUp"`：接上，我们在菜单栏开启了添加新记录功能之后，点击"分配新维修员"按钮，Grid就会在页面显示一个和现有列相同的输入行（EditMode默认值为"In Place"），描述不清，见下动图。

   [![cvvTrF.gif](https://z3.ax1x.com/2021/04/25/cvvTrF.gif)](https://imgtu.com/i/cvvTrF)

   将该属性值设为"PopUp"后，如文字描述，他就会将输入框变成小窗口的形式，如果我没有描述清楚的话，不妨运行一下程序，点击添加按钮查看效果。

   设置`EditMode="PopUp"`，他的弹出窗口中，各个文本框，还是按照`<Columns>`中定义的列生成的（就比如上图，Grid中数据列有FirstName、LastName、FullName，那么telerik默认给出的文本框就会是以上三项），如果想要自定义文本框，则需要添加`EditFormSettings > FormTemplate`标签(前端line29-40)自定义弹出框的样式，并设置`EditFormSettings > EditFormType="Template"`属性(前端line28)，告诉telerik，我需要使用自定义的edit form template，如下图。

   > When the **EditMode** property of a table view is "EditForms" or "PopUp", the table view's **EditFormSettings** property lets you configure the edit form. One of the **EditFormSettings** sub-properties is **EditFormType**, which lets you specify whether you want to use the built-in edit form or substitute your own custom edit form.

   [![cvx8Gq.png](https://z3.ax1x.com/2021/04/25/cvx8Gq.png)](https://imgtu.com/i/cvx8Gq)

   此处(前端Line29-40)，根据需求，在"分配新维修员"的输入窗口中，添加了一个combobox，combobox中填充的是所有维修人员列表，并有一个"确认"按钮和一个"取消"按钮。

   telerik为RadGrid封装了一些commandName，前文提到的codeless的添删改查、刷新等操作都可以通过在`ItemCommand()`中判断`e.CommandName`在后端进行捕捉。

   > ```c#
   > protected void RadGrid_ItemCommand(object sender, GridCommandEventArgs e)
   > {
   >     if (e.CommandName == RadGrid.InitInsertCommandName)
   >     {
   >         // Clicking on the "Add New Record" button to make the grid enter into insert mode
   >     }
   >     else if (e.CommandName == RadGrid.PerformInsertCommandName)
   >     {
   >         // When clicking on the Insert button after the values have been defined
   >     }
   >     else if (e.CommandName == RadGrid.EditCommandName)
   >     {
   >         // When clicking on the Edit button to put the Grid into edit mode
   >     }
   >     else if (e.CommandName == RadGrid.UpdateCommandName)
   >     {
   >         // When clicking on the Update button after the changes are done
   >     }
   >     else if (e.CommandName == RadGrid.DeleteCommandName)
   >     {
   >         // When the delete button is clicked for an item
   >     }
   >     else if (e.CommandName == RadGrid.PageCommandName)
   >     {
   >         // When Paging back and forth
   >     }
   >     else if (e.CommandName == RadGrid.SortCommandName)
   >     {
   >         // When sorting
   >     }
   >     else if (e.CommandName == RadGrid.FilterCommandName)
   >     {
   >         // When filtering
   >     }
   > }
   > ```

   根据官方文档，对`<FormTemplate>`中的按钮设置commandName："确认"按钮设置为"PerformInsert"，意为用户输入完成、执行插入，"取消"按钮设置为"Cancel"。

   并在后端对CommandName执行捕捉(后端line50-88)：

   * "分配新维修员" -> RadGrid.InitInsertCommandName -> 后端line52-64：

     用户对选中的项目执行"分配新维修员"操作，如果用户没有选中的项目，则不允许为空项目分配，否则为`<FormTemplate>`中的combobox赋数据源。

   * "确认" -> RadGrid.PerformInsertCommandName-> 后端line65-87：

     用户选好此项目的维修人员了，往`[projectDetailTable]`中插入一条记录。

   * "取消" -> RadGrid自行完成。

10. 前端Line12-15

    通过`<HeaderStyle>`指定该列的表头样式；

    通过`<ItemStyle>`指定该列的单元格样式，`Wrap="False"`即为不允许内容换行。

11. 前端Line16

    通过设置`Display="False"`，控制该列是否在用户界面上显示；

    注意与`Visible="False"`的区别，将visible设为false，由于asp.net的渲染机制，页面上完全不会渲染该列，而设置display属性，页面渲染时，会渲染这一列，仅仅是设置此列的`style.display="none"`。

    设置`Visible="False"`，可能会导致在通过`UniqueName`取值的时候，取不到内容而报错。

12. 前端Line18-21

    telerik支持对不同数据类型的数据在显示时进行格式化，仅需要通过设置`DataFormatString="{0:yyyy/MM/dd}"`，既可以完成对日期类型转换显示格式的工作。

13. 前端Line23-26

    ```html
    <telerik:GridHyperLinkColumn Text="View" Target="_blank" DataNavigateUrlFields="detailID" DataNavigateUrlFormatString="./RepairDetailPage.aspx?detailID={0}"></telerik:GridHyperLinkColumn>
    ```

    telerik对ASP.NET中HyperLinkColumn进行封装，功能是以超级链接来显示数据源中的一个字段内容，使用的语法是类似的。

    ![](http://www.phome.net/d/file/document/net/2005-04-02/acdd4094be63104e6108d2515ca2a351.jpg)

14. 后端Line1-8 `Page_Load()`

    页面初加载时，给GridDetail赋初值（空数据源）。

    调用从`[projectDetailTable]`中取数据的方法`getDetailData()`（根据项目号取项目下所有的维修人员），给项目号赋无效值0，那么取到的DataTable就是个空表，将空表作为初值给GridDetail，就能完成GridDetail的初始化（作用是，如果不赋初值的话，页面加载时不会显示这个Grid）。

15. 后端Line19-23 `GridDetail_NeedDataSource()`

    > Fired when RadGrid needs a data source for rebinding.

    当页面上的Grid需要数据源的时候就会触发此方法（比如翻页时、有Postback时...），方法体写的是从`ViewState`中取值（`getDetailData()`从数据库查询数据源的时候，会将最新的数据源存储到ViewState中）。

16. 后端Line25-48 `GridDetail_ItemDataBound()`

    > Fired after an item is databound to the RadGrid control.

    Grid被赋上数据源之后，有一个类似于一行行往页面上写/打印数据的过程，就是这个DataBound，当然看英文原意数据绑定的过程当然更准确，不过这么说或许有助于理解。

    在Grid得到数据源后，打印数据前，还可以对数据做一波处理，比如line90-91，从数据库取出的repairmanID是一个数字ID，不适合显示给客户，所以先要根据这个ID取得维修人员的姓名，代替原先的ID显示在页面上，line92-102的处理也类似，是将各种状态的状态码，转换为状态的名字。

    总而言之，这一步的处理是为了更用户友好。

17. 后端Line50-88 `GridDetail_ItemCommand()`

    > Fired when any button is clicked in the RadGrid control. All bubbled events from grid items fire RadGrid.ItemCommand. Those like - Edit, Delete, or Update command events can be used to handle custom data-editing in RadGrid. Expand/Collapse items in the hierarchy or GridGroupHeaderItem -s (if grid displays grouped items), also fired after binding of detail tables, etc.

    如前文第9点所述，不多赘述。

18. 后端Line90-101 `GridDetail_DeleteCommand`

    > Fired when the Delete button is clicked for an item in the RadGrid control.

    数据行的删除事件，执行数据库中的删除操作，也可以放在`GridDetail_ItemCommand() > if(e.CommandName==RadGrid.DeleteCommandName)`中捕捉，没有区别，先后顺序是ItemCommand -> DeleteCommand，单拎出来的理由可以是，删除操作更加慎重，拎出来在代码中看的更清晰之类的whatever。

    需要注意的是，在整个系统的数据库构建中，我们采用的删除操作叫"逻辑删除"，即是在所有表中添加一个`DeleteStatus`字段，删除操作就是`set DeleteStatus=0`，恢复就是`set DeleteStatus=1`。

    > 逻辑删除的本质是**修改操作**，所谓的逻辑删除其实并不是真正的删除，而是在表中将对应的是否删除标识（is_delete）或者说是状态字段（status）做修改操作。比如0是未删除，1是删除。在逻辑上数据是被删除的，但数据本身依然存在库中。
    >
    > 物理删除就是真正的从数据库中做删除操作了。

    通常对于处理业务、或者面向消费者的系统（事实上是大多数系统，基于我浅薄的见闻），都会采用逻辑删除的方式，因为业务/用户数据真的很重要。

    


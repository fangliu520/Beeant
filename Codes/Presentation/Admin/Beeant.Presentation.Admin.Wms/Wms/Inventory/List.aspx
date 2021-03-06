﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Beeant.Presentation.Admin.Wms.Wms.Inventory.List" MasterPageFile="~/Main.Master" %>
<%@ Import Namespace="Beeant.Basic.Services.WebForm.Extension" %>
<%@ Register src="/Controls/Pager.ascx" tagname="Pager" tagprefix="uc1" %>
 <%@ Register src="/Controls/DataSearch.ascx" tagname="DataSearch" tagprefix="uc2" %>
  <%@ Register src="/Controls/Progress.ascx" tagname="Progress" tagprefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
   <title>库存商品清单</title>  
 </asp:Content>
 <asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div id="divSearch" class="search" runat="server" >
           <table class="tb">
        <tr>
                <uc2:DataSearch ID="DataSearch1" runat="server" />
               
        </tr>
      
      <tr>
           <td class="font">
                    仓库名称 
                </td>
                <td class="text">
                       <asp:TextBox ID="txtStorehouseName" runat="server" CssClass="seinput" 
                        SearchParamterName="StorehouseName" 
                        SearchWhere="Storehouse.Name.Contains(@StorehouseName)">
                       </asp:TextBox>
                </td>
                 <td class="font">
                    产品编号 
                </td>
                <td class="mtext" colspan="5">
                       <asp:TextBox ID="txtId" runat="server" CssClass="seinput" 
                        SearchParamterName="Id"
                        SearchWhere="Id==@Id"></asp:TextBox>
                </td>
      </tr>
         <tr>
            <td class="font">
                显示内容
            </td>
            <td colspan="7" class="mtext">
                <asp:CheckBoxList ID="ckSelectList" runat="server">
                    <asp:ListItem  Value="Id" Text="编号" Selected="True" ></asp:ListItem>
                    <asp:ListItem  Value="Product.Id,Product.Name" Text="商品"  Selected="True"></asp:ListItem>
                    <asp:ListItem  Value="Storehouse.Id,Storehouse.Name" Text="仓库" Selected="True"  ></asp:ListItem>
                    <asp:ListItem  Value="Count" Text="数量"  Selected="True"></asp:ListItem>
                    <asp:ListItem  Value="LockCount" Text="锁定库存"  Selected="True"></asp:ListItem>
                    <asp:ListItem  Selected="True" Value="InsertTime" Text="录入时间" ></asp:ListItem>
                    <asp:ListItem  Value="UpdateTime" Text="编辑时间" ></asp:ListItem>
                </asp:CheckBoxList>
            </td>
            
        </tr>
        <tr>
            <td class="font">
                排序
            </td>
            <td class="mtext">
                <asp:DropDownList ID="ddlOrderbyList" runat="server">
                    <asp:ListItem  Value="Id" Text="编号" ></asp:ListItem>
                    <asp:ListItem  Value="Product.Id,Product.Name" Text="商品"  ></asp:ListItem>
                    <asp:ListItem  Value="Storehouse.Id" Text="仓库"  ></asp:ListItem>                    
                    <asp:ListItem  Value="Count" Text="数量" ></asp:ListItem>
                    <asp:ListItem  Value="LockCount" Text="锁定库存" ></asp:ListItem>
                    <asp:ListItem  Selected="True" Value="InsertTime" Text="录入时间" ></asp:ListItem>
                    <asp:ListItem  Value="UpdateTime" Text="编辑时间" ></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="font">
                排序方式
            </td>
            <td >
                <asp:RadioButtonList ID="rdOrderbyType" runat="server" RepeatDirection="Horizontal">
                     <asp:ListItem  Value="asc" Text="升序" ></asp:ListItem>
                     <asp:ListItem  Value="desc" Text="降序" Selected="True" ></asp:ListItem>
                </asp:RadioButtonList>
               
            </td>
            <td colspan="4">
                <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="btn"  />
                <asp:Button ID="btnSavePersonalization" runat="server" Text="保存" CssClass="btn"  />
                <asp:Button ID="btnClearPersonalization" runat="server" Text="清除" CssClass="btn"  />
            </td>
        </tr>
     </table>
        </div>

        <div class="mainten">
         <asp:Button ID="btnRemove" runat="server" Text="删除" CssClass="btn"></asp:Button>
        
        </div>

        <div class="list">
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table" >
       <Columns>
             <asp:BoundField  HeaderText="序号" ItemStyle-CssClass="sequence"/>
        <asp:TemplateField ItemStyle-CssClass="center ckbox">
            <HeaderTemplate>
             <input id="ckSelectAll" type="checkbox" AllCheckName="selectall"  />
            </HeaderTemplate>
            <ItemTemplate>
               <input value='<%#Eval("Id") %>' id="ckSelect" runat="server" type="checkbox" SubCheckName="selectall" ComfirmValidate="Remove"  />
           </ItemTemplate>
        </asp:TemplateField>

         <asp:TemplateField HeaderText="编号"  ItemStyle-CssClass="center xlstext">
            <ItemTemplate>
                <%#Eval("Id")%>
            </ItemTemplate>
        </asp:TemplateField>

         <asp:TemplateField HeaderText="商品"  ItemStyle-CssClass="right xlsfloat">
            <ItemTemplate>
           <a href='<%=this.GetUrl("PresentationAdminErpUrl") %>/Product/Product/Detail.aspx?id=<%#Eval("Product.Id") %>' target="_blank"><%#Eval("Product.Name")%></a>
            </ItemTemplate>
        </asp:TemplateField>
             <asp:TemplateField HeaderText="仓库"  ItemStyle-CssClass="right xlsfloat">
            <ItemTemplate>
           <a href='/Wms/Storehouse/Detail.aspx?id=<%#Eval("Storehouse.Id") %>' target="_blank"><%#Eval("Storehouse.Name")%></a>
            </ItemTemplate>
        </asp:TemplateField>
       <asp:TemplateField HeaderText="数量"  ItemStyle-CssClass="left">
            <ItemTemplate>
                <%#Eval("Count")%>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="锁定库存"  ItemStyle-CssClass="left">
            <ItemTemplate>
                <%#Eval("LockCount")%>
            </ItemTemplate>
        </asp:TemplateField>
          <asp:TemplateField HeaderText="打包数量"  ItemStyle-CssClass="left">
            <ItemTemplate>
                <%#Eval("PackCount")%>
            </ItemTemplate>
        </asp:TemplateField>
         <asp:TemplateField HeaderText="录入时间" ItemStyle-CssClass="center time">
            <ItemTemplate>
                <%#Eval("InsertTime","{0:yyyy-MM-dd HH:mm}")%>
            </ItemTemplate>
        </asp:TemplateField>
          <asp:TemplateField HeaderText="编辑时间" ItemStyle-CssClass="center time">
            <ItemTemplate>
                <%#Eval("UpdateTime","{0:yyyy-MM-dd HH:mm}")%>
            </ItemTemplate>
        </asp:TemplateField>
        </Columns>
     </asp:GridView>
     
     
            
     
     
     
     
     

        </div>
     <uc1:Pager ID="Pager1" runat="server" PageSize="10"   SelectExp="Id" OrderByExp="Id desc" />
     <uc3:Progress ID="Progress1" runat="server" />
     </ContentTemplate>
 </asp:UpdatePanel>

     

     

     

 </asp:Content>
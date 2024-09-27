<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCategorySiteBar.ascx.cs" Inherits="de1.UserControl.ucCategorySiteBar" %>
<hr />
<asp:Label ID="Label1" runat="server" Text="Course Category Available"></asp:Label>

<asp:DataList ID="DataList1" runat="server" DataKeyField="CatID" DataSourceID="ListCategoryEntityDataSource">
    <ItemTemplate>
        <asp:HyperLink ID="CatNameLabel" runat="server" Text='<%# Eval("CatName") + "("+ Eval("Courses.Count")+")" %>' NavigateUrl='<%# "~/Category.aspx?id=" + Eval("CatID")%>'></asp:HyperLink>
    </ItemTemplate>
</asp:DataList>
<asp:EntityDataSource ID="ListCategoryEntityDataSource" runat="server" ConnectionString="name=QLKhoaHocEntities" DefaultContainerName="QLKhoaHocEntities" EnableFlattening="False" EntitySetName="Categories" Include="Courses">
</asp:EntityDataSource>
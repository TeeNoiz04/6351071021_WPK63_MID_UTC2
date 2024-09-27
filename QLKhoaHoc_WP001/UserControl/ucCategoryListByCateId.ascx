<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCategoryListByCateId.ascx.cs" Inherits="de1.UserControl.ucCategoryListByCateId" %>
<asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="ListCourseEntityDataSource">
    <ItemTemplate>
        <div class="course_box">
            <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' CssClass="product_name"></asp:Label><br />
            <asp:Image ID="ImageFilePath" runat="server" Width="100px" Height="100px" ImageUrl='<%# "~/images/Courses/" + Eval("ImageFilePath")%>' /><br />
            <asp:Label ID="DurationLabel" runat="server" Text='<%# Eval("Duration") + "mins" %>' CssClass="product_price"></asp:Label><br />
            <asp:HyperLink ID="HyperLinkDetail" NavigateUrl='<%#"~/Detail.aspx?id="+Eval("ID") %>' runat="server" CssClass="product_view">View Details</asp:HyperLink>
        </div>
    </ItemTemplate>
    <LayoutTemplate>
        <div id="itemPlaceholderContainer" runat="server" style="">
            <span runat="server" id="itemPlaceholder" />
        </div>
        <div style="">
            <asp:DataPager ID="DataPager1" runat="server">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    <asp:NumericPagerField />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                </Fields>
            </asp:DataPager>
        </div>
    </LayoutTemplate>
</asp:ListView>
<asp:EntityDataSource ID="ListCourseEntityDataSource" runat="server" ConnectionString="name=QLKhoaHocEntities" DefaultContainerName="QLKhoaHocEntities" EnableFlattening="False" EntitySetName="Courses" Include="Category" Where="it.Category.CatID=@CategoryID">
    <WhereParameters>
        <asp:QueryStringParameter Name="CategoryID" QueryStringField="id" Type="Int32" />
    </WhereParameters>
</asp:EntityDataSource>
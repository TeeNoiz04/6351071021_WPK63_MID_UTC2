<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucManageProduct.ascx.cs" Inherits="de1.UserControl.ucManageProduct" %>

<table style="width:100%;">
    <tr>
        <td>Product name:</td>
        <td><asp:TextBox ID="TextBoxName" runat="server" ValidateRequestMode="Enabled" OnTextChanged="TextBoxName_TextChanged"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxName" ErrorMessage="Teen phai nhap"></asp:RequiredFieldValidator>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Duration</td>
        <td>
            <asp:TextBox ID="TextBoxDuration" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxDuration" ErrorMessage="Phai nhap duration"></asp:RequiredFieldValidator>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Category</td>
        <td><asp:DropDownList ID="DropDownListCategory" runat="server"></asp:DropDownList></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
    <td>Description</td>
    <td>
        <asp:TextBox ID="TextBoxDescription" TextMode="MultiLine" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBoxDescription" ErrorMessage="Phai nhap mo ta"></asp:RequiredFieldValidator>
        </td>
       
    <td>&nbsp;</td>
</tr>
    <tr>
     <td>Picture</td>
     <td>
         <asp:FileUpload ID="FileUploadPicture" runat="server" />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="FileUploadPicture" ErrorMessage="Chua upload file"></asp:RequiredFieldValidator>
        </td>
     <td>&nbsp;</td>
 </tr>

    <tr>
        <td>&nbsp;</td>
        <td>
            <asp:Button ID="ButtonAddNew" runat="server" Text="Add new" OnClick="ButtonAddNew_Click" /></td>
    </tr>
</table>

<hr />
<asp:GridView ID="GridViewProducts" AllowPaging="true" PageSize="5"  AutoGenerateColumns="false" runat="server" OnRowCommand="GridViewProducts_RowCommand" OnPageIndexChanging="GridViewProducts_PageIndexChanging" DataKeyNames="id">
<Columns>
    <asp:TemplateField HeaderText="No.">
        <ItemTemplate>
            <%# Container.DataItemIndex+1 %>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Picture">
        <ItemTemplate>
            <asp:Image runat="server" ID="imageProduct" ImageUrl='<%# "~/images/Courses/" + Eval("ImageFilePath") %>' Width="100px" Height="100px" />
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Name">
        <ItemTemplate>
            <asp:HyperLink ID="HyperLink1" Text='<%# Eval("Name")%>' Target="_blank" runat="server" NavigateUrl='<%# "~/Details.aspx?id="+Eval("id") %>'></asp:HyperLink>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField>
        <ItemTemplate>
            <asp:Button runat="server" OnClientClick="return confirm('Do you really want to delete this product?');" ID="DeleteButton" Text="Delete" CommandName="DeleteProduct" CommandArgument='<%# Eval("id") %>'/>
        </ItemTemplate>
    </asp:TemplateField>


        <asp:TemplateField>
    <ItemTemplate>
        <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditProduct" CommandArgument='<%# Eval("id") %>' />
    </ItemTemplate>
</asp:TemplateField>
</Columns>
</asp:GridView>
<hr />
<asp:Panel ID="pnlEditProduct" runat="server" Visible="false">
    <asp:Label ID="lblProductId" runat="server" Text="" Visible="false"></asp:Label>
    <asp:TextBox ID="txtEditProductName" runat="server" placeholder="Product Name"></asp:TextBox>
    <asp:TextBox ID="txtEditProductPrice" runat="server" placeholder="Product Price"></asp:TextBox>
    <asp:TextBox ID="txtEditProductDescription" runat="server" placeholder="Product Description"></asp:TextBox>
    <asp:DropDownList ID="dpEditProductCategory" runat="server"></asp:DropDownList>
    <asp:FileUpload ID="fulEditImageProduct" runat="server" />
    <asp:Button ID="btnUpdateProduct" runat="server" Text="Update" OnClick="btnUpdateProduct_Click" />
    <asp:Button ID="btnCancelUpdate" runat="server" Text="Cancel" OnClick="btnCancelUpdate_Click" />
</asp:Panel>

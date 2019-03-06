<%@ Page Title="" Language="C#" MasterPageFile="~/Styles/Site.Master" AutoEventWireup="true"
    CodeBehind="MyShoppingCart.aspx.cs" Inherits="SampleStoreNew_V1.MyShoppingCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="ShoppingCartTitle" runat="server" class="ContentHead">
        Shopping Cart</div>
    <asp:GridView ID="MyList" runat="server" AutoGenerateColumns="False" ShowFooter="True"
        GridLines="Vertical" CellPadding="4" DataSourceID="EDS_Cart" DataKeyNames="ProductID,UnitCost,Quantity"
        CssClass="CartListItem">
        <AlternatingRowStyle CssClass="CartListItemAlt" />
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="Product ID" ReadOnly="True" SortExpression="ProductID" />
            <asp:BoundField DataField="ModelNumber" HeaderText="Model Number" SortExpression="ModelNumber" />
            <asp:BoundField DataField="ModelName" HeaderText="Model Name" SortExpression="ModelName" />
            <asp:BoundField DataField="UnitCost" HeaderText="Unit Cost" ReadOnly="True" SortExpression="UnitCost"
                DataFormatString="{0:c}" />
            <asp:TemplateField>
                <HeaderTemplate>
                    Quantity</HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="PurchaseQuantity" Width="40" runat="server" Text='<%# Bind("Quantity") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    Item&nbsp;Total</HeaderTemplate>
                <ItemTemplate>
                    <%# (Convert.ToDouble(Eval("Quantity")) * Convert.ToDouble(Eval("UnitCost")))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    Remove&nbsp;Item</HeaderTemplate>
                <ItemTemplate>
                    <center>
                        <asp:CheckBox ID="Remove" runat="server" />
                    </center>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle CssClass="CartListFooter" />
        <HeaderStyle CssClass="CartListHead" />
    </asp:GridView>
    <div style="float: right">
        <strong>
            <asp:Label ID="LabelTotalText" runat="server" Text="Order Total : ">
            </asp:Label>
            <asp:Label CssClass="NormalBold" ID="lblTotal" runat="server" EnableViewState="false">
            </asp:Label>
        </strong>
    </div>
    <br />
    <asp:ImageButton ID="UpdateBtn" runat="server" ImageUrl="Styles/Images/update_cart.gif"
        OnClick="UpdateBtn_Click"></asp:ImageButton>
    <asp:ImageButton ID="CheckoutBtn" runat="server" ImageUrl="Styles/Images/final_checkout.gif"
        PostBackUrl="~/CheckOut.aspx"></asp:ImageButton>
    <asp:EntityDataSource ID="EDS_Cart" runat="server" ConnectionString="name=CommerceEntities"
        DefaultContainerName="CommerceEntities" EnableFlattening="False" EnableUpdate="True"
        EntitySetName="ViewCarts" AutoGenerateWhereClause="True" EntityTypeFilter=""
        Select="" Where="">
        <WhereParameters>
            <asp:SessionParameter Name="CartID" DefaultValue="0" SessionField="TailSpinSpyWorks_CartID" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>

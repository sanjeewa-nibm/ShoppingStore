<%@ Page Title="" Language="C#" MasterPageFile="~/Styles/Site.master" AutoEventWireup="true"
    CodeBehind="ProductsList.aspx.cs" Inherits="SampleStoreNew_V1.ProductsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ListView ID="ListView_Products" runat="server" DataKeyNames="ProductID" DataSourceID="EDS_ProductsByCategory"
        GroupItemCount="2">
        <EmptyDataTemplate>
            <table id="Table1" runat="server">
                <tr>
                    <td>
                        No data was returned.
                    </td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
            <td id="Td1" runat="server" />
        </EmptyItemTemplate>
        <GroupTemplate>
            <tr id="itemPlaceholderContainer" runat="server">
                <td id="itemPlaceholder" runat="server">
                </td>
            </tr>
        </GroupTemplate>
        <ItemTemplate>
            <td id="Td2" runat="server">
                <table border="0" width="300">
                    <tr>
                        <td style="width: 25px;">
                            &nbsp
                        </td>
                        <td style="vertical-align: middle; text-align: right;">
                            <a href='ProductDetails.aspx?productID=<%# Eval("ProductID") %>'>
                                <image src='Catalog/Images/Thumbs/<%# Eval("ProductImage") %>' width="100" height="75"
                                    border="0">
                            </a>&nbsp;&nbsp;
                        </td>
                        <td style="width: 250px; vertical-align: middle;">
                            <a href='ProductDetails.aspx?productID=<%# Eval("ProductID") %>'><span class="ProductListHead">
                                <%# Eval("ModelName") %></span><br>
                            </a><span class="ProductListItem"><b>Special Price: </b>
                                <%# Eval("UnitCost", "{0:c}")%></span><br>
                            <a href='AddToCart.aspx?productID=<%# Eval("ProductID") %>'><span class="ProductListItem">
                                <b>Add To Cart<b></font></span></a>
                        </td>
                    </tr>
                </table>
            </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td3" runat="server">
                        <table id="groupPlaceholderContainer" runat="server">
                            <tr id="groupPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="Tr2" runat="server">
                    <td id="Td4" runat="server">
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
    <asp:FormView ID="FormView_Product" runat="server" DataKeyNames="ProductID" DataSourceID="EDS_Product">
        <ItemTemplate>
            <div class="ContentHead">
                <%# Eval("ModelName") %></div>
            <br />
            <table border="0">
                <tr>
                    <td style="vertical-align: top;">
                        <img src='Catalog/Images/<%# Eval("ProductImage") %>' border="0" alt='<%# Eval("ModelName") %>' />
                    </td>
                    <td style="vertical-align: top">
                        <%# Eval("Description") %>
                        <br />
                        <br />
                        <br />
                    </td>
                </tr>
            </table>
            <span class="UnitCost"><b>Your Price:</b>&nbsp;<%# Eval("UnitCost", "{0:c}")%></span><<br />
            <span class="ModelNumber"><b>Model Number:</b>&nbsp;<%# Eval("ModelNumber") %></span><br /><a href='AddToCart.aspx?ProductID= <%# Eval("ProductID") %>' style="border: 0 none white"><img id="Img1" src="~/Styles/Images/add_to_cart.gif" runat="server" alt="" style="border-width: 0" /></a><br /><br />
        </ItemTemplate>
    </asp:FormView>
    <asp:EntityDataSource ID="EDS_Product" runat="server" AutoGenerateWhereClause="True"
        EnableFlattening="False" ConnectionString="name=CommerceEntities" DefaultContainerName="CommerceEntities"
        EntitySetName="Products" EntityTypeFilter="" Select="" Where="">
       <WhereParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="productID" Type="Int32" />
        </WhereParameters>
        
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EDS_ProductsByCategory" runat="server" EnableFlattening="False"
        AutoGenerateWhereClause="True" ConnectionString="name=CommerceEntities" DefaultContainerName="CommerceEntities"
        EntitySetName="Products">
        <WhereParameters>
            <asp:QueryStringParameter Name="CategoryID" QueryStringField="CategoryId" Type="Int32" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>

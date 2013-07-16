<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="Default.aspx.cs" 
    Inherits="ExtGridPanelPaging._Default" %>

<%@ Register Assembly="Ext.Net" 
             Namespace="Ext.Net" 
             TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
            "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ext GridPanel Paging</title>
    <style type="text/css">
        body
        {
            padding: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" Theme="Default">
    </ext:ResourceManager>
    <!-- Veri Kaynağı Oluşturuluyor (Başlangıç)!-->
    <ext:Store ID="StoreCustomers" runat="server">
        <Reader>
            <ext:JsonReader>
                <Fields>
                    <ext:RecordField Name="RID" Type="Int" />
                    <ext:RecordField Name="FIRSTNAME" Type="String" />
                    <ext:RecordField Name="LASTNAME" Type="String" />
                    <ext:RecordField Name="INSERTIONTIME" Type="String" />
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <!-- Veri Kaynağı Oluşturuluyor (Bitiş) !-->
    <ext:GridPanel ID="GRDCustomers" 
                    Frame="false" 
                    runat="server" 
                    Title="Customers List"
                    Icon="Application" 
                    StoreID="StoreCustomers" 
                    Border="true" 
                    StripeRows="true" 
                    DeferRowRender="true"
                    TrackMouseOver="true" 
                    Height="250" 
                    Width="420">
                    
        <ColumnModel ID="ColumnModel1" runat="server">
            <Columns>
                <ext:Column DataIndex="RID" 
                            Header="Indetity">
                </ext:Column>
                <ext:Column DataIndex="FIRSTNAME" 
                            Header="FirstName">
                </ext:Column>
                <ext:Column DataIndex="LASTNAME" 
                            Header="LastName">
                </ext:Column>
                <ext:Column DataIndex="INSERTIONTIME" 
                            Header="InsertionTime">
                </ext:Column>
            </Columns>
        </ColumnModel>
        
        <LoadMask ShowMask="true" Msg="Yükleniyor." />
        <SelectionModel>
            <ext:RowSelectionModel ID="RowSelectionModel1" 
                                    runat="server" 
                                    SingleSelect="true">
            </ext:RowSelectionModel>
        </SelectionModel>
        
        <BottomBar>
            <ext:Toolbar runat="server" ID="PagingNavigator1">
                <Items>
                    <ext:Button runat="server" 
                                ID="btnfirst" 
                                Icon="ResultsetFirst">
                        <Listeners>
                            <Click Handler="#{txtPageIndex}.setValue(1);" />
                        </Listeners>
                        <DirectEvents>
                            <Click OnEvent="OnPageIndexChanged">
                                <ExtraParams>
                                    <ext:Parameter Name="pageIndex" 
                                                   Value="1" 
                                                   Mode="Raw">
                                    </ext:Parameter>
                                </ExtraParams>
                                <EventMask Msg="Listeleniyor.." 
                                           ShowMask="true" />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    
                    <ext:Button runat="server" 
                                ID="btnprior" 
                                Icon="ResultsetPrevious">
                        <Listeners>
                            <Click Handler="var pagecount=parseInt(#{lblPageCount}.getText()); var index=parseInt(#{txtPageIndex}.getValue()); if (index > 1 ) { index=index-1; #{txtPageIndex}.setValue(index);}" />
                        </Listeners>
                        <DirectEvents>
                            <Click OnEvent="OnPageIndexChanged">
                                <ExtraParams>
                                    <ext:Parameter Name="pageIndex" 
                                                   Value="#{txtPageIndex}.getValue()" 
                                                   Mode="Raw">
                                    </ext:Parameter>
                                </ExtraParams>
                                <EventMask Msg="Listeleniyor.." 
                                           ShowMask="true" />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    
                    <ext:ToolbarSeparator>
                    </ext:ToolbarSeparator>
                    
                    <ext:ToolbarTextItem Text="Page" 
                                         runat="server"/>
                                         
                    <ext:NumberField runat="server" 
                                     ID="txtPageIndex" 
                                     Width="40" 
                                     Text="1">
                        <DirectEvents>
                            <Change OnEvent="OnPageIndexChanged">
                                <ExtraParams>
                                    <ext:Parameter Name="pageIndex" 
                                                   Value="#{txtPageIndex}.getValue()"
                                                   Mode="Raw">
                                    </ext:Parameter>
                                </ExtraParams>
                                <EventMask Msg="Listeleniyor..." 
                                           ShowMask="true" />
                            </Change>
                        </DirectEvents>
                    </ext:NumberField>
                    
                    <ext:ToolbarTextItem runat="server" 
                                         Text="/" />

                    
                    <ext:ToolbarTextItem ID="lblPageCount" 
                                         runat="server"/>

                    <ext:ToolbarSeparator runat="server"/>
                    
                    <ext:Button runat="server" 
                                ID="btnnext" 
                                Icon="ResultsetNext">
                        <Listeners>
                            <Click Handler="var pagecount=parseInt(#{lblPageCount}.getText()); var index=parseInt(#{txtPageIndex}.getValue()); if (index < pagecount) { index=index+1; #{txtPageIndex}.setValue(index);}" />
                        </Listeners>
                        <DirectEvents>
                            <Click OnEvent="OnPageIndexChanged">
                                <ExtraParams>
                                    <ext:Parameter Name="pageIndex" 
                                                   Value="#{txtPageIndex}.getValue()" 
                                                   Mode="Raw">
                                    </ext:Parameter>
                                </ExtraParams>
                                <EventMask Msg="Listeleniyor.." 
                                           ShowMask="true" />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button runat="server" 
                                ID="btnlast" 
                                Icon="ResultsetLast">
                        <Listeners>
                            <Click Handler="#{txtPageIndex}.setValue(#{lblPageCount}.getText());" />
                        </Listeners>
                        <DirectEvents>
                            <Click OnEvent="OnPageIndexChanged">
                                <ExtraParams>
                                    <ext:Parameter Name="pageIndex" 
                                                   Value="#{lblPageCount}.getText()" 
                                                   Mode="Raw">
                                    </ext:Parameter>
                                </ExtraParams>
                                <EventMask Msg="Listeleniyor.." 
                                           ShowMask="true" />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:ToolbarSeparator runat="server"/>
                    <ext:ToolbarTextItem ID="lblInfo" 
                                         runat="server"/>
                </Items>
            </ext:Toolbar>
        </BottomBar>
    </ext:GridPanel>
    </form>
</body>
</html>

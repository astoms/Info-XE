﻿unit UModelTree;

interface

uses
  Classes, SysUtils, StdCtrls, Controls,
  OracleData, Oracle, ComCtrls, Windows, Vcl.Dialogs,CommCtrl, Winapi.Messages, Vcl.Graphics;

const
  activecard = 'and a.ACCEPTED=1';

type
  TModelTree = class(TComponent)
  private
    function GetNodeValue(str: string): string;
    function GetNameFromStr(Str: string): string;
    function AddChild(node: TTreeNode; Str: string): TTreeNode;
    function IsNodeNameLen(Str: string; len1, len2: integer): boolean;
    function GetNodeLevel(data: string): integer;
  protected
    FTreeView: TTreeView;
    mouse_x: integer;
    mouse_y: integer;
    StrList: TStringList;
  published
  public
    FSelectedNode: TTreeNode;
    constructor Create(AOwner: TComponent); override;
    function GetSelNodeValue: string;
    procedure SetModelData(ATreeView: TTreeView);
    procedure GetDataForTree();
    procedure GetSortedNodeList();
    procedure DrawTree;
    function TreeItemSearch(SearchItem: string): TTreeNode;
    procedure FindNodeByName(TreeNode: string);
  end;

implementation

uses Variants, unit2;

procedure TModelTree.FindNodeByName(TreeNode: string);
var
   Node: TTreeNode;
   Shift : TShiftState;
   Button : TMouseButton;
begin
 try
   Node:= TreeItemSearch(TreeNode);
   FTreeView.Selected:= Node;
   FTreeView.SetFocus;
   Button:=mbLeft;
   Shift:=[ssAlt];
 except
 end;
end;

function TModelTree.TreeItemSearch(SearchItem: string): TTreeNode;
var
  i: Integer;
  iItem: string;
begin
  if (FTreeView = nil) or (SearchItem = '')
  then Exit;
  for i := 0 to FTreeView.Items.Count - 1 do begin
    iItem := FTreeView.Items[i].Text;
    if SearchItem = iItem then begin
      Result := FTreeView.Items[i];
      Exit;
    end else begin
      Result := nil;
    end;
  end;
end;

procedure TModelTree.GetDataForTree();
var
  SQL_query: string;
begin
  SQL_query:=('select a.tree, a.name from Supermag.SACardClass a');
  MainForm.TreeModel.Active:=false;
  MainForm.TreeModel.CommandText:=SQL_query;
  MainForm.TreeModel.Active:=true;
end;

function SortedList(data : string):string;
const
  concstr : string = '000';
var
  i : integer;
  j : integer;
  ch : string;
  str : string;
  instr : string;
begin
  //showMessage(data);
  try
    str:=''; j:=0;
    for i:=0 to strlen(pchar(data)) do begin
      ch:=copy(data,i,1);
      if (ch='.') then begin
        instr:=copy(data,i-j+1,j);
        instr:=copy(concstr,0,3-strlen(pchar(instr)))+instr;
        str:=str+instr;
        j:=0;
      end;
      inc(j);
    end;
    SortedList:=str;
  except
  end;
end;

function cutstr(str : string): string;
var i: integer;
  res: string;
  ch : string;
begin
  res:='';
  for i:=1 to 15 do
  begin
    ch:=copy(str,i,1);
    if ch=' ' then break else res:=res+ch;
  end;
  cutstr:=res;
end;

procedure TModelTree.GetSortedNodeList();
var
  i: integer;
  node: string;
const
  CONST_STR: string = '               ';
begin
  MainForm.TreeModel.First;
  i:=1;
  FTreeView.Items.Clear;
  StrList.Clear;

  while i <= MainForm.TreeModel.RecordCount do
  begin
    node:= VarToStr(MainForm.TreeModel.FieldValues['TREE']);
    if node <> '#' then begin
      node:= SortedList(VarToStr(MainForm.TreeModel.FieldValues['TREE']));
      node:= node + copy(CONST_STR, 0, 15 - strlen(pchar(node)));
      StrList.Add(node + VarToStr(MainForm.TreeModel.FieldValues['TREE']) + ' ' + VarToStr(MainForm.TreeModel.FieldValues['NAME']));
    end;
    MainForm.TreeModel.Next;
    inc(i);
  end;
end;

function TModelTree.GetNameFromStr(Str: string): string;
begin
  result:= copy(Str, 16, strlen(pchar(Str)) - 12);
end;

function TModelTree.AddChild(node: TTreeNode; Str: string): TTreeNode;
begin
  result:= FTreeView.Items.AddChild(node, Str) ;
  result.ImageIndex:= 0;
  result.SelectedIndex:= 1;
end;

function TModelTree.IsNodeNameLen(Str: string; len1, len2: integer): boolean;
begin
  if (strlen(pchar(Str))=len1) or (strlen(pchar(Str)) = len2)
  then result:= true
  else result:= false;
end;

function TModelTree.GetNodeLevel(data: string): integer;
begin
  if ((IsNodeNameLen(data, 3, 3)) or (IsNodeNameLen(data, 3, 4)) or (IsNodeNameLen(data, 3, 5))) then
  result:= 0
  else if ((IsNodeNameLen(data, 6, 7)) or (IsNodeNameLen(data, 6, 8)))  then
  result:= 1
  else if ((IsNodeNameLen(data, 9, 10)) or (IsNodeNameLen(data, 9, 11))) then
  result:= 2
  else if ((IsNodeNameLen(data, 12, 13)) or (IsNodeNameLen(data, 12, 14))) then
  result:= 3
  else if ((IsNodeNameLen(data, 15, 16)) or (IsNodeNameLen(data, 15, 17))) then
  result:= 4
  else
  result:=5;
end;

procedure TModelTree.DrawTree();
var
  i: integer;
  level: integer;
  data : string;
  nodeName: string;
  NodeList: array[0..10] of TTreeNode;
begin
  NodeList[0]:= AddChild(nil, 'Все') ;

  for i:= 0 to StrList.Count-1 do begin
    data:= cutstr(copy(StrList[i], 0, 18));
    nodeName:= GetNameFromStr(StrList[i]);

    level:= GetNodeLevel(data);
    if level < 8
    then NodeList[level + 1]:= AddChild(NodeList[level], nodeName) ;
  end;
  MainForm.TreeView.SortType:=stNone;
  MainForm.TreeView.AlphaSort();
end;

function TModelTree.GetNodeValue(str: string):string;
var
  ch, st : string;
  i : integer;
begin
  i:= 1; ch:= '';
  while (st <>' ') do
  begin
    st:=copy(str, i, 1);
    ch:=ch + st;
    inc(i);
  end;
  result:= copy(ch, 0, strlen(pchar(ch)) - 1);
end;

constructor TModelTree.Create(AOwner: TComponent);
begin
  inherited;
  StrList:= TStringList.Create;
  StrList.Sorted:= True;
  FSelectedNode:= nil;
end;

procedure TModelTree.SetModelData(ATreeView: TTreeView);
begin
  FTreeView:= ATreeView;
end;

function TModelTree.GetSelNodeValue: string;
begin
  Result:= '';
  if Assigned(FSelectedNode) and (FSelectedNode.Text <> 'Все') then begin
    Result:= GetNodeValue(FSelectedNode.Text);
  end;
end;

end.

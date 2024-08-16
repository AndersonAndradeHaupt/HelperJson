unit JsonHelper;

interface

uses
  System.SysUtils, System.JSON, System.Classes, JsonHelper.interfaces;

type
  TJSONHelper = class(TInterfacedObject, IJSONHelper)
  private
    FJSONValue: TJSONValue;
    FJsonCriado: Boolean;
  public
    constructor Create(const AJSON: string); overload;
    constructor Create(AJSONValue: TJSONValue; AOwnsJSONValue: Boolean = False); overload;
    destructor Destroy; override;
    class function New(const AJSON: string): IJSONHelper;
    function GetArray(const AName: string): IJSONHelper;
    function GetObject(const AName: string): IJSONHelper;
    function GetValue(const AName: string): TJSONValue;
    function GetValueAsString(const AName: string): string;
    function GetValueFromArray(Index: Integer): IJSONHelper;
    function GetArrayCount: Integer;
  end;

implementation

constructor TJSONHelper.Create(const AJSON: string);
begin
  inherited Create;
  FJSONValue := TJSONObject.ParseJSONValue(AJSON);
  if not (FJSONValue is TJSONObject) and  not (FJSONValue is TJSONArray) then
    raise Exception.Create('Json invalido');
  FJsonCriado := True;
end;

constructor TJSONHelper.Create(AJSONValue: TJSONValue; AOwnsJSONValue: Boolean);
begin
  inherited Create;
  FJSONValue := AJSONValue;
  FJsonCriado := AOwnsJSONValue;
end;

destructor TJSONHelper.Destroy;
begin
  if FJsonCriado then
    FJSONValue.Free;
  inherited;
end;

class function TJSONHelper.New(const AJSON: string): IJSONHelper;
begin
  Result := TJSONHelper.Create(AJSON) as IJSONHelper;
end;

function TJSONHelper.GetArray(const AName: string): IJSONHelper;
var
  JSONArray: TJSONArray;
  Value: TJSONValue;
begin
  Value := (FJSONValue as TJSONObject).GetValue(AName);
  if not (Value is TJSONArray) then
    raise Exception.CreateFmt('Array "%s" não encontrado ou invalido', [AName]);

  JSONArray := Value as TJSONArray;
  Result := TJSONHelper.Create(JSONArray, False) as IJSONHelper
end;

function TJSONHelper.GetArrayCount: Integer;
begin
    if FJSONValue is TJSONArray then
    Result := TJSONArray(FJSONValue).Count
  else
    raise Exception.Create('Não é JSON array');
end;

function TJSONHelper.GetObject(const AName: string): IJSONHelper;
var
  JSONObject: TJSONObject;
  Value: TJSONValue;
begin
  Value := (FJSONValue as TJSONObject).GetValue(AName);
  if not (Value is TJSONObject) then
    raise Exception.CreateFmt('Object "%s" não encontrado ou invalido', [AName]);

  JSONObject := Value as TJSONObject;
  Result := TJSONHelper.Create(JSONObject, False) as IJSONHelper;
end;

function TJSONHelper.GetValue(const AName: string): TJSONValue;
begin
  Result := (FJSONValue as TJSONObject).GetValue(AName);
  if Result = nil then
    raise Exception.CreateFmt('Field "%s" não encontrato', [AName]);
end;

function TJSONHelper.GetValueAsString(const AName: string): string;
begin
  Result := GetValue(AName).Value;
end;

function TJSONHelper.GetValueFromArray(Index: Integer): IJSONHelper;
var
  JSONArray: TJSONArray;
begin
  if not (FJSONValue is TJSONArray) then
    raise Exception.Create('Não é um JSON array');

  JSONArray := FJSONValue as TJSONArray;
  if (Index >= 0) and (Index < JSONArray.Count) then
    Result := TJSONHelper.Create(JSONArray.Items[Index], False) as IJSONHelper
  else
    raise Exception.CreateFmt('Index %d não encontrado', [Index]);
end;

end.


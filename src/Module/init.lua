export type SwitchType = {
	case: (self: SwitchType, Value: any, Bind: () -> nil) -> SwitchType;
	default: (self: SwitchType, Bind: () -> nil) -> nil;
}

type ListItemType = {} | () -> nil;

local SwitchClass = {}
SwitchClass.__index = SwitchClass

function SwitchClass.new(): SwitchType
	local self = setmetatable({},SwitchClass)
	
	self.List = {}
	
	return self
end

function SwitchClass:AddToList(Info: ListItemType | number, Index: ListItemType?)
	for _, Value: ListItemType in ipairs(self.List) do
		if (type(Value) ~= "function") then continue end
		if (type(Info) == "number") and (#self.List > Info) then break end

		warn("A :default is already made for this switch, you can't add anything after the default!")
		return true
	end

	if (Index) then
		table.insert(self.List,Info,Index)
	else
		table.insert(self.List,Info)
	end
end

function SwitchClass:GetValue(Bind: () -> nil | any)
	if (type(Bind) == "function") then
		return Bind()
	end

	return Bind
end

function SwitchClass:case(Value: any, Bind: () -> nil): SwitchType
	self:AddToList{
		Value = Value;
		Bind = Bind;
	}
	
	return self
end

function SwitchClass:default(Bind: () -> nil)
	if (type(Bind) == "function") then
		self:AddToList(Bind)
	else
		self:AddToList(function()
			return Bind
		end)
	end
	
	return self
end

-- Metamethods

-- Adds the ability to call the SwitchClass
function SwitchClass:__call(Expression: string)
	for Index: number, Statement: {Value: any, Bind: () -> nil} in ipairs(self.List) do
		if (type(Statement) == "function") then
			return Statement()
		end
		
		if (Statement.Value ~= Expression) then continue end
		-- if (type(Statement.Bind) ~= "function") then continue end
		
		return self:GetValue(Statement.Bind)
	end
end

-- Adds the ability to add two SwitchClasses together with the + operator
function SwitchClass:__add(Switch: SwitchType)
	if not (Switch) then return end

	for _, Item in ipairs(self.List) do
		local DidError = Switch:AddToList(1,Item)
		if (DidError) then break end
	end

	return Switch
end

return function(): SwitchType
	return SwitchClass.new()
end
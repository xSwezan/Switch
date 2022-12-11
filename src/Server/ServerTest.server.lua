local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Switch = require(ReplicatedStorage.MainModule)

local FooSwitch: Switch.SwitchType = Switch()
:case("foo",function()
	warn("OMG FOO I AM YOUR FAN")
	return "Foo"
end)
:case("bar","bar")

print("c")

local FooPlusSwitch = FooSwitch + Switch()
:case("test",Vector2.new(1,2))
:case("test2", "testaaaa")
:default("Default Reached!")

print(FooPlusSwitch)

print(FooSwitch("test"))
print(FooPlusSwitch("test"))
print(FooPlusSwitch("foo"))
print(FooPlusSwitch("test2"))
print(FooSwitch("test"))
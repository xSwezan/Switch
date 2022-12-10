---
sidebar_position: 1
---

# useSpring

## Overview

Defines values into animated values.

### Either: declaratively overwrite values to change the animation

If you re-render the component, the animation will update.

```lua
local styles = RoactSpring.useSpring(hooks, {
    transparency = if toggle then 1 else 0,
})
```

If you want the animation to run on mount, you can use `from` to set the initial value.

```lua
local styles = RoactSpring.useSpring(hooks, {
    from = { transparency = 0 },
    to = { transparency = if toggle then 1 else 0 },
})
```

### Or: pass a function that returns values, and imperatively update using the api

You will get an API table back. It will not automatically animate on mount and re-render, but you can call `api.start` to start the animation. Handling updates like this is generally preferred as it's more powerful. Further documentation can be found in [Imperatives](/docs/common/imperatives).

```lua
local styles, api = RoactSpring.useSpring(hooks, function()
    return { transparency = 0 }
})

-- Update spring with new props
api.start({ transparency = if toggle then 1 else 0 })
-- Stop animation
api.stop()
```

### Finally: apply styles to components

```lua
return Roact.createElement("Frame", {
    Transparency = styles.transparency,
    Size = UDim2.fromScale(0.3, 0.3),
})
```

## Properties

All properties documented in the [common props](/docs/common/props) apply.

## Additional notes

### To-prop shortcut
Any property that useSpring does not recognize will be combined into "to", for instance `transparency = 1` will become `to = { transparency = 1 }`.

```lua
-- This...
local styles = RoactSpring.useSpring({ transparency = 1 })
-- is a shortcut for this...
local styles = RoactSpring.useSpring({ to = { transparency = 1 } })
```

## Demos

### Draggable element

<a href="https://github.com/chriscerie/roact-spring/blob/main/stories/hooks/useSpringDrag.story.lua">
  <img src="https://media.giphy.com/media/R2bJ57MNTdP7vmP6Ez/giphy.gif" width="400" />
</a>
--[[

  Simple Corona event delegation.

--]]

local memo = {}
local state = {} -- Store current/most recent event data for each channel

-- Publish a global event on @channel with @data
function memo.pub(channel, data)
  Runtime:dispatchEvent({name = channel, data = data})
  state[channel] = data
end

-- Subscribe function @fn to @channel
-- Can access data via `event.data` @fn args `function(event)`
function memo.sub(channel, fn)
  Runtime:addEventListener(channel, fn)
end

-- Unsubscribe function @fn from @channel
function memo.unsub(channel, fn)
  Runtime:removeEventListener(channel, fn)
end

-- Subscribe @object to @channel with function @fn
-- Can access data via `event.data` @fn args `function(self, event)`
function memo.subo(object, channel, fn)
  object[channel] = fn
  Runtime:addEventListener(channel, object)
end

-- Unsubscribe @object from @channel
function memo.unsubo(object, channel)
  Runtime:removeEventListener(channel, object)
end

-- Access the most recent `event.data` for @channel
function memo.stateOf(channel)
  return state[channel]
end

return memo

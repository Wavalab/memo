--[[

  Simple Corona event delegation.

--]]

local memo = {}

-- Publish a global event on @channel with @data
function memo.pub(channel, data)
  Runtime:dispatchEvent({name = channel, data = data})
end

-- Subscribe function @fn to @channel
function memo.sub(channel, fn)
  Runtime:addEventListener(channel, fn)
end

-- Unsubscribe function @fn from @channel
function memo.unsub(channel, fn)
  Runtime:removeEventListener(channel, fn)
end

-- Subscribe @object to @channel with function @fn
function memo.subo(object, channel, fn)
  object[channel] = fn
  Runtime:addEventListener(channel, object)
end

-- Unsubscribe @object from @channel
function memo.unsubo(object, channel)
  Runtime:removeEventListener(channel, object)
end

return memo

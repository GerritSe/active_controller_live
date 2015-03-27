jQuery.fn.flash = (x, c) ->
  self = this
  interval = 300

  this.$$flashUp = ->
    $(self).addClass(c)

  this.$$flashDown = ->
    $(self).removeClass(c)

  i = 0
  nextTimeout = 1
  while i < x * 2
    setTimeout ->
      self.$$flashUp()
    , nextTimeout
    nextTimeout = ++i * interval
    setTimeout ->
      self.$$flashDown()
    , nextTimeout
    nextTimeout = ++i * interval
  return

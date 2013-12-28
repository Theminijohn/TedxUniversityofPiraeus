(($) ->
  $.easyPieChart = (el, options) ->
    addScaleLine = undefined
    animateLine = undefined
    drawLine = undefined
    easeInOutQuad = undefined
    rAF = undefined
    renderBackground = undefined
    renderScale = undefined
    renderTrack = undefined
    _this = this
    @el = el
    @$el = $(el)
    @$el.data "easyPieChart", this
    @init = ->
      percent = undefined
      scaleBy = undefined
      _this.options = $.extend({}, $.easyPieChart.defaultOptions, options)
      percent = parseInt(_this.$el.data("percent"), 10)
      _this.percentage = 0
      _this.canvas = $("<canvas width='" + _this.options.size + "' height='" + _this.options.size + "'></canvas>").get(0)
      _this.$el.append _this.canvas
      G_vmlCanvasManager.initElement _this.canvas  if typeof G_vmlCanvasManager isnt "undefined" and G_vmlCanvasManager isnt null
      _this.ctx = _this.canvas.getContext("2d")
      if window.devicePixelRatio > 1
        scaleBy = window.devicePixelRatio
        $(_this.canvas).css
          width: _this.options.size
          height: _this.options.size

        _this.canvas.width *= scaleBy
        _this.canvas.height *= scaleBy
        _this.ctx.scale scaleBy, scaleBy
      _this.ctx.translate _this.options.size / 2, _this.options.size / 2
      _this.ctx.rotate _this.options.rotate * Math.PI / 180
      _this.$el.addClass "easyPieChart"
      _this.$el.css
        width: _this.options.size
        height: _this.options.size
        lineHeight: "" + _this.options.size + "px"

      _this.update percent
      _this

    @update = (percent) ->
      percent = parseFloat(percent) or 0
      if _this.options.animate is false
        drawLine percent
      else
        animateLine _this.percentage, percent
      _this

    renderScale = ->
      i = undefined
      _i = undefined
      _results = undefined
      _this.ctx.fillStyle = _this.options.scaleColor
      _this.ctx.lineWidth = 1
      _results = []
      i = _i = 0
      while _i <= 24
        _results.push addScaleLine(i)
        i = ++_i
      _results

    addScaleLine = (i) ->
      offset = undefined
      offset = (if i % 6 is 0 then 0 else _this.options.size * 0.017)
      _this.ctx.save()
      _this.ctx.rotate i * Math.PI / 12
      _this.ctx.fillRect _this.options.size / 2 - offset, 0, -_this.options.size * 0.05 + offset, 1
      _this.ctx.restore()

    renderTrack = ->
      offset = undefined
      offset = _this.options.size / 2 - _this.options.lineWidth / 2
      offset -= _this.options.size * 0.08  if _this.options.scaleColor isnt false
      _this.ctx.beginPath()
      _this.ctx.arc 0, 0, offset, 0, Math.PI * 2, true
      _this.ctx.closePath()
      _this.ctx.strokeStyle = _this.options.trackColor
      _this.ctx.lineWidth = _this.options.lineWidth
      _this.ctx.stroke()

    renderBackground = ->
      renderScale()  if _this.options.scaleColor isnt false
      renderTrack()  if _this.options.trackColor isnt false

    drawLine = (percent) ->
      offset = undefined
      renderBackground()
      _this.ctx.strokeStyle = (if $.isFunction(_this.options.barColor) then _this.options.barColor(percent) else _this.options.barColor)
      _this.ctx.lineCap = _this.options.lineCap
      _this.ctx.lineWidth = _this.options.lineWidth
      offset = _this.options.size / 2 - _this.options.lineWidth / 2
      offset -= _this.options.size * 0.08  if _this.options.scaleColor isnt false
      _this.ctx.save()
      _this.ctx.rotate -Math.PI / 2
      _this.ctx.beginPath()
      _this.ctx.arc 0, 0, offset, 0, Math.PI * 2 * percent / 100, false
      _this.ctx.stroke()
      _this.ctx.restore()

    rAF = (->
      window.requestAnimationFrame or window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or (callback) ->
        window.setTimeout callback, 1000 / 60
    )()
    animateLine = (from, to) ->
      anim = undefined
      startTime = undefined
      _this.options.onStart.call _this
      _this.percentage = to
      startTime = Date.now()
      anim = ->
        currentValue = undefined
        process = undefined
        process = Date.now() - startTime
        rAF anim  if process < _this.options.animate
        _this.ctx.clearRect -_this.options.size / 2, -_this.options.size / 2, _this.options.size, _this.options.size
        renderBackground.call _this
        currentValue = [easeInOutQuad(process, from, to - from, _this.options.animate)]
        _this.options.onStep.call _this, currentValue
        drawLine.call _this, currentValue
        _this.options.onStop.call _this  if process >= _this.options.animate

      rAF anim

    easeInOutQuad = (t, b, c, d) ->
      easeIn = undefined
      easing = undefined
      easeIn = (t) ->
        Math.pow t, 2

      easing = (t) ->
        if t < 1
          easeIn t
        else
          2 - easeIn((t / 2) * -2 + 2)

      t /= d / 2
      c / 2 * easing(t) + b

    @init()

  $.easyPieChart.defaultOptions =
    barColor: "#ef1e25"
    trackColor: "#f2f2f2"
    scaleColor: "#dfe0e0"
    lineCap: "round"
    rotate: 0
    size: 160
    lineWidth: 8
    animate: false
    onStart: $.noop
    onStop: $.noop
    onStep: $.noop

  $.fn.easyPieChart = (options) ->
    $.each this, (i, el) ->
      $el = undefined
      instanceOptions = undefined
      $el = $(el)
      unless $el.data("easyPieChart")
        instanceOptions = $.extend({}, options, $el.data())
        $el.data "easyPieChart", new $.easyPieChart(el, instanceOptions)


  undefined
) jQuery
$(document).ready ->
  $(".percentage").easyPieChart
    animate: 1000
    onStep: (value) ->
      @$el.find("span").text ~~value

  $(".percentage-gray").easyPieChart
    animate: 1000
    barColor: "#333333"
    trackColor: "#bcbcbc"
    scaleColor: "#fff"
    onStep: (value) ->
      @$el.find("span").text ~~value

  $(".percentage-blue").easyPieChart
    animate: 1000
    barColor: "#fff"
    trackColor: "#18b5de"
    scaleColor: "#fff"
    onStep: (value) ->
      @$el.find("span").text ~~value

  $(".percentage-green").easyPieChart
    animate: 1000
    barColor: "#fff"
    trackColor: "#638110"
    scaleColor: "#fff"
    onStep: (value) ->
      @$el.find("span").text ~~value


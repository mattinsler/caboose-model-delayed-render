_ = require 'underscore'
caboose = Caboose.exports
util = Caboose.util
logger = Caboose.logger
Promise = Caboose.exports.promise

isPlainObject = (obj) ->
  return false if !obj or toString.call(obj) isnt '[object Object]' or obj.nodeType or obj.setInterval
  return false if obj.constructor and !hasOwnProperty.call(obj, 'constructor') and !hasOwnProperty.call(obj.constructor.prototype, 'isPrototypeOf')
  0 for key in obj
  key is undefined or hasOwnProperty.call(obj, key)

module.exports =
  'caboose-plugin': {
    install: (util, logger) ->
      return logger.error('caboose-model is a prerequisite.  Please install it first.') if Caboose.app.plugins.indexOf('caboose-model') is -1
      
      logger.title 'Running installer for caboose-model-delayed-render'
    
    initialize: ->
      return logger.error('caboose-model is a prerequisite.  Please install it first.') if Caboose.app.plugins.indexOf('caboose-model') is -1
      
      if Caboose?
        Responder = caboose.controller.Responder
        Promise = require('caboose-model').Promise
        
        _respond = Responder::respond
        Responder::respond = (opts) ->
          get_promises = (obj) ->
            promises = []
            for k, v of obj
              do (k, v) ->
                promises.push({object: obj, key: k, promise: v}) if v instanceof Promise
                promises.push.apply(promises, get_promises(v)) if isPlainObject(v)
            promises
            
          promises = get_promises(opts.controller).concat(get_promises(opts.options))
          # console.log "#{promises.length} promise(s)"
          return _respond.call(@, opts) if promises.length is 0
          
          done = _.after promises.length, => _respond.call(@, opts)

          for p in promises
            do (p) ->
              p.promise.on 'complete', (value) ->
                p.object[p.key] = value
                done()
  }

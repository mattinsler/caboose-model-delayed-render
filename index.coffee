_ = require 'underscore'
caboose = Caboose.exports
util = Caboose.util
logger = Caboose.logger
Promise = Caboose.exports.promise

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
              promises.push({object: obj, key: k, promise: v}) if v instanceof Promise
              promises.push.apply(promises, get_promises(v)) if _.isObject(v)
            promises
            
          promises = get_promises(opts)
          return _respond.call(@, opts) if promises.length is 0
          
          done = _.after promises.length, => _respond.call(@, opts)

          for p in promises
            do (p) ->
              p.promise.on 'complete', (value) ->
                p.object[p.key] = value
                done()
  }

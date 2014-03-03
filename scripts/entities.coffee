define ['components'], (C) ->
  class EntityManager
    constructor: ->
      @store = {}
      @entities_by_tag = {}
      @tags_by_entity = {}

    create: (component) ->
      eid = 0 # generate eid somehow
      @addComponent(eid, component)
      return eid

    addComponent: (entity_id, component) ->
      type = component.type
      @store[type] ?= {}
      @store[type][entity_id] = component
      return @

    removeComponent: (entity_id, component) ->
      delete @store[component.type][entity_id]
      return @

  return { EntityManager }

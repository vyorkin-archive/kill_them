# Basic ECS engine.
# WARNING: This engine is not optimized.
World = (->
  nextID = 0
  entities = []
  entitiesToComponents = []
  componentsToEntities = {}

  # Internal entity definition.
  Entity =

    # Retrieves the specified component.
    get: (comp) ->
      entitiesToComponents[@id][comp.name]

    # Adds the specified component.
    add: (component) ->
      name = component.constructor.name
      componentsToEntities[name] = []  unless componentsToEntities[name]
      entitiesToComponents[@id][name] = component
      componentsToEntities[name][@id] = true
      return

    # Removes the specified component.
    remove: (component) ->
      delete entitiesToComponents[@id][component.name]
      delete componentsToEntities[component.name][@id]
      return

    # Kills the entity.
    kill: ->
      delete entities[@id]
      delete entitiesToComponents[@id]

      for comp of componentsToEntities
        delete componentsToEntities[comp][@id]
      return

  # Creates a new entity.
  createEntity: (components) ->
    entityID = nextID++
    entity = Object.create(Entity,
      id:
        value: entityID
        writable: false
    )
    entities[entityID] = entity
    entitiesToComponents[entityID] = {}
    if components
      components.forEach (component) ->
        entity.add component
        return

    entity


  # Returns all entities having the specified component.
  match: (comp) ->
    Object.keys(componentsToEntities[comp.name] or []).map (entityID) ->
      entities[entityID]

)()

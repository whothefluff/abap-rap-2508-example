*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class handler definition
              inheriting from cl_abap_behavior_event_handler.

  private section.

    methods handle_deleted for entity event
              importing
                entities for ShipmentStatus~Deleted.

endclass.
class handler implementation.

  method handle_deleted.

    loop at entities reference into final(e).

      "do something

    endloop.

  endmethod.

endclass.

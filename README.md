# abap-rap-master-data-app

This repository is a comprehensive API to manage a ver simple master data BO. It uses most of the features of RAP and it's correctly configured for extensibilty.

General Considerations:
* Generator only works with one table and therefore it's useless for all intents and purposes
* ID must be a **UUID** of type _x_ and length 16 (corresponds to dictionary type _raw(16)_) to be able to be created **automatically**
* Root entities should have the following **management** fields **exactly** to allow working with drafts and etags in a versatile manner. Otherwise there are conflicts in the behavior defintions
  * db
    ```ABAP
    local_created_by      : abp_creation_user; 
    local_created_at      : abp_creation_utcl;
    local_last_changed_by : abp_locinst_lastchange_user;
    local_last_changed_at : abp_locinst_lastchange_utcl;
    total_last_changed_at : abp_lastchange_utcl;
    ```  
  * model
    ```ABAP CDS
    @Semantics.user.createdBy: true
    local_created_by as LocalCreatedBy,
    @Semantics.systemDateTime.createdAt: true
    local_created_at as LocalCreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    local_last_changed_by as LocalLastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    total_last_changed_at as TotalLastChangedAt,
    ```
* Child entities should have the following:
  * db
    ```ABAP
    created_by      : abp_creation_user;
    created_at      : abp_creation_utcl;
    last_changed_by : abp_locinst_lastchange_user;
    last_changed_at : abp_locinst_lastchange_utcl;
     ```
  * model
    ```ABAP CDS
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    last_changed_at as LastChangedAt,
    ```
* **Persistent** tables should have prefix A and their fields should use **snake_case**. **Draft** tables instead have prefix D and their fields must use **flatcase**. Otherwise there are mapping problems with the behavior definitions
* For DB **extension fields**, the name must use **flatcase**. This makes it possible to reuse the same include structure for both the persistent table and the draft table.
* The CDS model of each entity should consist of a **base** entity with prefix P (SAP uses R _sometimes_), a transactional **interface** on top to serve as a **stable** contract (therefore released with C1 contract) using prefix I, and a transactional query on the outmost layer with prefix A
* Views of the top layer (prefix A) can use contract C2 but that makes them incompatible with many unreleased annotations. In case of wanting to expose it as a web API it is necessary to create two top projections, one for external use and one for UIs. The reason is that the projection contracts don't support indeterminate projections (this has another problem: any agumentations in a given projection would have to be implemented again for another projection)
* To be able to have an API that mimics a very simple SM30 instance with a text table, the minimum required version is **7.58** of ABAP (ABAP Platform/SAP S/4HANA 2023). While technically it should have been possible to have it in 7.57, it had a bug that resulted in runtime errors.
  * Even then, to achieve this, addition _:localized_ must be added to a field in the top projection and the create/update standard operations must use addition _agument_. Finally this feature must be implemented **manually** in the behavior implementation of the projection.
* Also since **7.58**, projection entities with localized fields allow buffered descriptions through a **propagated buffer**. But again, it has a bug and it results in a runtime error.
* Value Help definitions don't need a specific view and any other released CDS can be used if appropriate.
* Ideally, the base CDS of a root entity should have at most 23 characters to allow for some extra suffixes and prefixes.
* To allow **extensibilty**, only a handful of objects actually have to be released as C0 (well documented)

UI Observations
* Field order should always be explicitely defined (and with gaps) to make easier for extensions to be placed in between original fields
* It's a good idea to always add a facet of type IDENTIFICATION_REFERENCE to each entity, even if it's not actually used, because then extensions can make use of it easily
* The easiest way of having a page **aumatically** load entries **at start** is to create a variant with any filters and set it as default

> [!NOTE]
> The repository contains a package EXT_EG with an actual example of a possible extension. This can be ignored altogether

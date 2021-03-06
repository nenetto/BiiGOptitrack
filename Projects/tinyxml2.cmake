# Author: Eugenio Marinetto
# Date: 2015-02-18

set(EP_OPTION_NAME "USE_${EP_NAME}")
set(EP_REQUIRED_PROJECTS Git)
set(EP_URL "https://github.com/leethomason/tinyxml2.git")

cma_end_definition()
# -----------------------------------------------------------------------------



set(EP_OPTION_NAME "USE_${EP_NAME}")
set(EP_REQUIRED_PROJECTS Git)
set(EP_URL "https://github.com/leethomason/tinyxml2.git")
set(EP_OPTION_DESCRIPTION "${EP_NAME} Project")
set(EP_OPTION_DEFAULT OFF)

cma_list(APPEND EP_REQUIRED_PROJECTS Doxygen IF ${PROJECT_NAME}_BUILD_DOCUMENTATION)

cma_end_definition()
# -----------------------------------------------------------------------------




if(${PROJECT_NAME}_tinyxml2_EXTERNAL_DIR)

    ExternalProject_Add(${EP_NAME}
       DOWNLOAD_COMMAND ""
       CONFIGURE_COMMAND ""
       BUILD_COMMAND ""
       INSTALL_COMMAND "")

  set(${PROJECT_NAME}_${EP_NAME}_DIR ${${PROJECT_NAME}_tinyxml2_EXTERNAL_DIR} CACHE INTERNAL "")

else()
    set(EP_CMAKE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=OFF
    -DBUILD_STATIC_LIBS:BOOL=ON
    -DBUILD_TESTING:BOOL=OFF
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
    -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
    -DCMAKE_INSTALL_PREFIX:PATH=${PROJECT_BINARY_DIR}/${EP_NAME}-install
    )


  ExternalProject_Add(${EP_NAME}
    DEPENDS ${EP_REQUIRED_PROJECTS}
    # download
    GIT_REPOSITORY ${EP_URL}
    GIT_TAG 2.2.0
    # patch
    # update
    UPDATE_COMMAND ""
    # configure
    SOURCE_DIR ${PROJECT_BINARY_DIR}/${EP_NAME}
    CMAKE_ARGS ${EP_CMAKE_ARGS}
    # build
    BINARY_DIR ${PROJECT_BINARY_DIR}/${EP_NAME}-build
    # install
    # install
    INSTALL_DIR ${${PROJECT_NAME}_INSTALL_DIR}
    INSTALL_COMMAND
    # test
    )

  set(${PROJECT_NAME}_${EP_NAME}_DIR ${PROJECT_BINARY_DIR}/${EP_NAME}-install CACHE INTERNAL "")

endif()
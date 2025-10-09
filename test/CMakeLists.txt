configure_lit_site_cfg(
  ${CMAKE_CURRENT_SOURCE_DIR}/lit.site.cfg.py.in
  ${CMAKE_CURRENT_BINARY_DIR}/lit.site.cfg.py
  MAIN_CONFIG
  ${CMAKE_CURRENT_SOURCE_DIR}/lit.cfg.py
)

set(DIALEGG_TEST_DEPS egg-opt)

add_lit_testsuite(check-dialegg "Running the dialegg regression tests"
        ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${DIALEGG_TEST_DEPS}
        )
set_target_properties(check-dialegg PROPERTIES FOLDER "Tests")

add_lit_testsuites(DialEgg ${CMAKE_CURRENT_SOURCE_DIR} DEPENDS ${DIALEGG_TEST_DEPS})

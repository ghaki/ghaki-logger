export GK_PROJECT_IDEPS=( \
  "$(pwd)/../ghaki-core/lib" \
  )
export GK_PROJECT_GO_DIRS=( \
  "lib:${GK_PROJECT_DIR}/lib/ghaki/logger" \
  "spec:${GK_PROJECT_DIR}/spec/ghaki/logger" \
  "bin:${GK_PROJECT_DIR}/scripts" \
  )

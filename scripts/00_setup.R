required_packages <- c("tidyverse", "janitor", "here", "naniar", "skimr", "openxlsx")
for (pkg in required_packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    cat("✅", pkg, "→ مثبتة\n")
  } else {
    cat("❌", pkg, "→ غير مثبتة\n")
  }
}

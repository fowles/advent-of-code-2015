import Darwin

do {
  chdir(getenv("BUILD_WORKING_DIRECTORY"))
  try day1()
} catch {
  print("Error: \(error).")
}

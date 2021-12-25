import Darwin

do {
  chdir(getenv("BUILD_WORKING_DIRECTORY"))
  try Day1.main()
} catch {
  print("Error: \(error).")
}

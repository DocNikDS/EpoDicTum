# 1. Define your input and output folders
input_dir <- "./raw-images"
output_dir <- "./images"

# 2. Create the output folder if it doesn't exist yet
if (!dir.exists(output_dir)) dir.create(output_dir)

# 3. Get all jpg files (ignoring uppercase/lowercase)
files <- list.files(input_dir, pattern = "\\.jpg$", full.names = TRUE, ignore.case = TRUE)

# 4. Loop through every file
for (f in files) {
  filename <- basename(f)
  out_path <- file.path(output_dir, filename)
  
  # Build the command arguments
  args <- c("-i", f, "-o", out_path, "-s", "2") 
  
  # Run the command (capturing both success and error messages)
  output <- system2("realesrgan-ncnn-vulkan.exe", args = args, stdout = TRUE, stderr = TRUE)
  
  # Report back to the console
  if (file.exists(out_path)) {
    print(paste("SUCCESS:", filename))
  } else {
    print(paste("FAILED:", filename))
    print(paste("Reason:", paste(output, collapse = "\n")))
  }
}
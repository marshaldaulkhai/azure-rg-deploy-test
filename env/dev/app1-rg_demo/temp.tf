variable "webapp_type" {
  description = "Specifies the type of web application to deploy (react, angular, or others)."
  type        = string
  default     = "react" # Default to 'react' to maintain current behavior
  validation {
    condition     = contains(["react", "angular", "others"], var.webapp_type)
    error_message = "The webapp_type must be 'react', 'angular', or 'others'."
  }
}

# Part 2: # Module calls for React WebApp and Angular App

module "react_webapp" {
  count = var.webapp_type == "react" ? 1 : 0 # This line to change ,Deploy only if webapp_type is "react"
  ... # remaining code same...
}

# New module call to add
module "angular_webapp" {
  count = var.webapp_type == "angular" ? 1 : 0
  ... # to code ...
}

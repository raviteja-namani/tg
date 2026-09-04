terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

# Sleeps 30s, nothing else. That window is long enough to trigger a second
# execution against the same workspace and watch it get rejected with 423
# while this run holds the lock.
#
# The timestamp() trigger forces a replace on every apply, so the sleep
# happens on every run instead of only the first.
resource "null_resource" "wait" {
  triggers = {
    always = timestamp()
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }
}

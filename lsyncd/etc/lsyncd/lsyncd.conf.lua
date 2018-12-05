settings = {
  logfile = "/tmp/lsyncd.log",
  statusFile = "/tmp/lsyncd-status.log",
  statusInterval = 20
}

sync {
  default.rsync,
  source = "/home/timothy/dotfiles/",
  target = "timothy@10.0.0.141:/home/timothy/dotfiles/",
  rsync = {
    compress = true,
    verbose = true,
    rsh = "/usr/bin/ssh -p 22 -i /home/timothy/.ssh/id_ed25519 -o StrictHostKeyChecking=no"
  }
}

sync {
  default.rsync,
  source = "/home/timothy/bin/",
  target = "timothy@10.0.0.141:/home/timothy/bin/",
  rsync = {
    compress = true,
    verbose = true,
    rsh = "/usr/bin/ssh -p 22 -i /home/timothy/.ssh/id_ed25519 -o StrictHostKeyChecking=no"
  }
}

sync {
  default.rsync,
  source = "/home/timothy/projects/",
  target = "timothy@10.0.0.141:/home/timothy/projects/",
  rsync = {
    compress = true,
    verbose = true,
    rsh = "/usr/bin/ssh -p 22 -i /home/timothy/.ssh/id_ed25519 -o StrictHostKeyChecking=no"
  }
}

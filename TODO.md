* Investigate migrating to nix
* fixup syntastic vs lsp vs whatever in nvim
* Investigate replacing docker with podman (and docker-compose with
  podman-compose). Docker has been the source of many compatibility breakages,
  has a lot of ugly workarounds in install.sh and setup.sh because its always
  breaking shit so we can't just use the packages from the distro and because it
  needs root access to work, and generally is just a very immature organization.
  Features I think need to work in podman (and/or podman-compose):
  * named-volumes (could be replaced with bind mounts if perf is same)
  * muliple containers all brought up with one command 
  * exposing ports and having the containers able to communicate with one
    another and with the outside world
  * using a network proxy both for building images and for running containers
  * multi container builds (i.e. not having javac in the final container if a
    java program was needed to be compiled)
  * if the container is run locally, being able to escalate oneself to root in
    the container
  * image build caching of some sort
  * being able to relocate the local image repository to another location
    although if this could be worked around with a symlink that's probably fine
    too
  * injecting/setting environment variables into the running container at
    startup
  * if podman-compose has an equivalent to docker network, which I'm assuming it
    does, it should have a config setting for setting the default-address-pool
    space
  * preferably all of this would be available from the podman and podman-compose
    packages in the distro, without needing to add a ppa or curl | bash or
    similar

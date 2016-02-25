Vault-Docker
====

A simple, minimal image for Hashicorp's Vault based on
Alpine Linux. Vault is downloaded from Hashicorp's distribution
CDN and cryptographically verified with GnuPG.

Server Configuration
----

Override the default configuration using Vault's [environment variables](https://www.vaultproject.io/docs/commands/environment.html) or
mount a volume of your choosing at /etc/vault containing a [valid vault configuration file](https://www.vaultproject.io/docs/config/). By default,
all files ending in `.hcl` and `.json` will be loaded in the server configuration. Note that the default command launches the server in development
mode. In this mode, the server starts unsealed and prints a root token to the screen for authentication use.

Note that because Vault will only listen to 127.0.0.1 in it's built in devmode we're going to default to using a file backend to store your
secrets on your docker host. Note that this means you'll be running a production equivalent configuration, aside from the fact that we've
disabled TLS here while it'll be enabled in production.

To start the server such that you can access it on your development workstation do the following:

    $ docker run -it --hostname vault --name vault jaesharp/vault-docker:0.5.0-1

Client Usage
----

If you do not have the vault installed on your local workstation, alias the vault client inside the docker container to a more comfortable command:

    $ alias vault="docker run --rm --link vault:vault -e "VAULT_ADDR=http://vault:8200/" jaesharp/vault-docker:0.5.0-1"
    $ vault version # to test

The first time you start vault on your development machine, you'll have to run the init command first to set up the secret storage volume. See [the
documentation related to deploying vault](https://www.vaultproject.io/intro/getting-started/deploy.html) for more information.

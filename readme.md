# #BAG minecraft server configuration.

An automated configuration for the #BAG minecraft server.

## Development

1. Make sure you have vagrant installed
2. Clone this repo
3. Run `./script/setup`
4. Make the server with `vagrant up`
5. Make any changes to the puppet configuration
6. Test them with `vagant provision`
  1. Ensure your changes work by logging into the box or performing what ever
     tests you need to perform
7. Open a PR and ask someone to review it for you
  1. if you're making a configuration change, please explain why the
     configuration change is necessary.

## Advice

**Never manually modify the whitelist**. Add the user to the whitelist with a
configuration change to puppet.

You can give yourself SSH capability with full root access by adding a
`ghuser { 'your github user name': }` resource call to the `site.pp` file.
